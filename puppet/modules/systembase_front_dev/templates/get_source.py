#!/usr/bin/env python
# -*- coding: utf-8 -*-
#fanzhilin@letv.com
#version: 1.5

import os
import sys
import time
import copy
import json
import Queue
import random
import shutil
import hashlib
import urllib2
import logging
try:
    import requests
except:
    pass
import datetime
import optparse
import threading
import traceback
import ConfigParser





def exit_script_warnning():
    os.remove(pid_file)
    logging.warning("exit...")
    sys.exit(1)

def exit_script():
    os.remove(pid_file)
    logging.info("exit...")
    sys.exit(1)

def get_str_md5(src):
    m0=hashlib.md5()
    m0.update(src)
    md5 = m0.hexdigest()
    return md5


def get_host_cdnid():
    try:
        with open('/usr/local/etc/hosts.conf', 'r') as hosts_file_obj:
            for i in hosts_file_obj.readlines():
                if i.strip().startswith('host_cdnid'):
                    cdnid = int(i.split()[1].split(";")[0])
                    break
            if cdnid:
                return cdnid
            else:
                logging.warning("/usr/local/etc/hosts.conf can't read cdnid...")
                return False
    except:
        logging.warning("/usr/local/etc/hosts.conf read cdnid occur error...")
        return False


def get_local_ip(ifname):
    import socket, fcntl, struct
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        inet = fcntl.ioctl(s.fileno(), 0x8915, struct.pack('256s', ifname[:15]))
        ret = socket.inet_ntoa(inet[20:24])
    except:
        ret = False
    return ret


def get_host_ip():
    for dev in ['bond0', 'eth0', 'eth1', 'em0', 'em1' , 'bce0' , 'bce1']:
        host_ip = get_local_ip(dev)
        if host_ip:
            break
    if host_ip:
        return host_ip
    else:
        return False



def dev_not_post_to_g3():
    #当设备是没跑过新回源架构的，第一次写配置文件不成功的话，设备不上报调度
    try:
        with open('/etc/hosts', 'a+') as hosts_obj:
            hosts_obj.seek(0, 0)
            hosts_txt = hosts_obj.read()
            if "88.88.88.88 report.gslb.letv.com" in hosts_txt:
                return True
            else:
                hosts_obj.seek(0, 2)
                hosts_obj.write("\n88.88.88.88 report.gslb.letv.com\n")
    except:
        logging.warning("dev_not_post_to_g3:write fail...")
        return False
    return True

def dev_post_to_g3():
    #设备跑过新回源架构的，上次没成功写配置文件，这次成功了，就恢复上报调度
    try:
        with open('/etc/hosts', 'r') as hosts_obj:
            hosts_txt = hosts_obj.read()
        if "88.88.88.88 report.gslb.letv.com" in hosts_txt:
            tmp = hosts_txt.replace('88.88.88.88 report.gslb.letv.com','')
            with open('/etc/hosts', 'w') as hosts_obj:
                hosts_obj.write(tmp)
    except:
        logging.warning("dev_post_to_g3:write fail...")
        return False
    return True


class LogWriteTime(object):
    def __init__(self,filename):
        global nginx_write_time
        self.nginx_write_time = nginx_write_time
        self.filename = filename

    @property
    def need_write(self):
        #如果文件的修改时间大于设定的值就需要写配置
        #文件不存在也需要写
        if not os.path.exists(self.filename):
            logging.info(self.filename + " not exists,need write...")
            return True
        try:
            filename_mtime =  int(os.path.getmtime(self.filename))
        except:
            return True
        now_time = int(time.time())
        if now_time - filename_mtime > int(self.nginx_write_time):
            logging.info(self.filename + " time to write...")
            return True
        else:
            logging.info("no need to write " + str(now_time) + ' ' + str(filename_mtime) )
            return False

def from_g3_get_info_2(param):
    #线上有设备requsts库报错之后用urllib2
    import urllib2
    global g3_url
    args = ''
    for j in param:
        if args:
            args = "%s&%s=%s" % (args, j, param[j])
        else:
            args = "?%s=%s" % (j, param[j])
    host_cdnid = get_host_cdnid()
    for i in g3_url:
        full_url = i + args
        ulb = urllib2.urlopen(full_url, timeout = 3)
        if str(ulb.getcode()).startswith('20'):
            break
    tmp = ulb.read()
    context = json.loads(tmp)
    if context:
        return context
    else:
        return False


def from_g3_get_info(param):
    #请求调度接口的函数，20x状态码认为成功，其他认为失败
    global g3_url
    host_cdnid = get_host_cdnid()
    if host_cdnid:
        param['cdnid'] = host_cdnid
    else:
        host_ip = get_host_ip()
        if host_ip:
            param['uip'] = host_ip
    for i in g3_url:
        try:
            r = requests.get(i, params=param , timeout=5)
        except NameError:
            logging.warning("requests class fail,use urllib2...")
            context = from_g3_get_info_2(param)
            if context:
                return context
            else:
                return False
        except:
            continue
        if not str(r.status_code).startswith('20'):
            continue
        else:
            break
    try:
        context = r.json()
    except:
        logging.warning("fail:connect to g3 failed")
        return False
    return context

class GetPolicy(threading.Thread):
    #多线程去请求调度接口拿域名回源信息
    #因为是采用group形式，所以一个group下可能会有多个域名，先选一个group下的域名，然后以这个域名去请求调度
    def __init__(self,queue):
        self.queue = queue
        threading.Thread.__init__(self)
    def run(self):
        global mutex
        global policy_dict
        while True:
            try:
                policy_name = self.queue.get_nowait()
            except:
                break
            if not policy_name:
                continue
            if policy_name == 'default':
                param = {}
            else:
                domain = G3Interface().get_represent_domain(policy_name)
                if not domain:
                    logging.warning("fail:" + policy_name + " get from g3 fail...")
                    continue
                param = {'domain': domain}
            domain_info = from_g3_get_info(param)
            #增加兼容调度接口异常的情况，如果调度返回节点ip状态全部为0的情况下重试3次
            if policy_name == 'default':
                for i in range(3):
                    status = 0
                    if domain_info.has_key('myhostlist'):
                        for j in domain_info['myhostlist']:
                            if j['status'] == 1:
                                status = 1
                        if status == 1:
                            break
                    domain_info = from_g3_get_info(param)
            if domain_info:
                if mutex.acquire(1):
                    try:
                        policy_dict[policy_name]['text'] = domain_info
                    except:
                        logging.warning(policy_name + " init policy_dict error")
                    finally:
                        mutex.release()
            else:
                logging.warning("fail:"+ policy_name + " from g3 get fail...")



class G3Interface(object):
    def get_all_domain(self):
        #先刷一次调度，取到所有非默认的域名
        global policy_dict
        param = {'sign': 'getdomain'}
        domain = from_g3_get_info(param)
        if domain:
            for i in domain:
                if domain[i] not in policy_dict:
                    policy_dict[domain[i]] = {}
                    policy_dict[domain[i]]['domain'] = []
                    policy_dict[domain[i]]['text'] = {}
                policy_dict[domain[i]]['domain'].append(i)
            policy_dict['default'] = {}
            policy_dict['default']['text'] = {}
            return policy_dict
        else:
            logging.warning("fail:get domain info rom g3 fail...")
            exit_script_warnning()

    def get_represent_domain(self,policy_name):
        #从一个group里面选一个域名出来
        global policy_dict
        try:
            domain = policy_dict[policy_name]['domain'][0]
            if domain:
                return domain
            else:
                return False
        except Exception:
            tb = traceback.format_exc()
            logging.warning(tb)
            logging.warning("fail:get represent domain fail...")
            return False

    def get_group_info(self):
        global get_group_thread_num
        global policy_dict
        queue=Queue.Queue()
        threads=[]
        for i in policy_dict:
            if not i:
                continue
            queue.put(i)
        for _ in range(get_group_thread_num):
            t = GetPolicy(queue=queue)
            try:
                t.setDaemon(True)
            except Exception:
                tb = traceback.format_exc()
                logging.warning(tb)
                return False
            t.start()
            threads.append(t)
        while True:
            isAlive = False
            for t in threads:
                isAlive = isAlive or t.isAlive()
            if not isAlive:
                break
            time.sleep(1)
        return True


def post(post_data):
    #post到nginx接口，重试3次，非20x认为失败
    global nginx_api
    for i in range(3):
        try:
            r = requests.post(nginx_api, data=post_data)
            post_code = str(r.status_code)
        except:
            try:
                req = urllib2.Request(nginx_api, post_data)
                response = urllib2.urlopen(req)
                post_code = str(response.code)
            except:
                continue
        if 'post_code' in dir():
            if not post_code.startswith('20'):
                continue
            else:
                logging.info("success: " + post_data)
                return True
    logging.warning("fail:post to nginx fail " + post_data)


class Policy(object):
    def __init__(self):
        global policy_log_file
        self.policy_file = policy_log_file
    def log_policy(self):
        #记录所有的group的内容，用于下次执行的时候，判断是否有更新
        global policy_dict
        with open(self.policy_file ,"w") as policy_file_obj:
            policy_file_obj.write(json.dumps(policy_dict))
    @property
    def need_post_policy(self):
        #从上次记录的group内容，判断是否需要更新
        #记录文件不在，默认当次的group都更新
        #从记录文件取到的内容，需要删除一些动态的key，才用于比对
        global policy_dict
        tmp_policy_dict = copy.deepcopy(policy_dict)
        policy_name = tmp_policy_dict.keys()
        if not os.path.exists(self.policy_file):
            return policy_name
        with open(self.policy_file , 'r') as policy_file_obj:
            policy_log_json = policy_file_obj.read()
        try:
            policy_log_json = json.loads(policy_log_json)
        except ValueError:
            os.remove(self.policy_file)
            return policy_name
        for i in tmp_policy_dict:
            if not policy_log_json.has_key(i):
                continue
            if tmp_policy_dict[i].has_key('text') and policy_log_json[i].has_key('text'):
                if tmp_policy_dict[i]['text'].has_key('curtime'):
                    del tmp_policy_dict[i]['text']['curtime']
                if tmp_policy_dict[i]['text'].has_key('userid'):
                    del tmp_policy_dict[i]['text']['userid']
                if tmp_policy_dict[i]['text'].has_key('domain'):
                    del tmp_policy_dict[i]['text']['domain']
                if tmp_policy_dict[i]['text'].has_key('server'):
                    del tmp_policy_dict[i]['text']['server']
                if policy_log_json[i]['text'].has_key('curtime'):
                    del policy_log_json[i]['text']['curtime']
                if policy_log_json[i]['text'].has_key('userid'):
                    del policy_log_json[i]['text']['userid']
                if policy_log_json[i]['text'].has_key('domain'):
                    del policy_log_json[i]['text']['domain']
                if policy_log_json[i]['text'].has_key('server'):
                    del policy_log_json[i]['text']['server']
                if policy_log_json[i]['text'] == tmp_policy_dict[i]['text']:
                    if not policy_log_json[i].has_key('domain'):
                        os.remove(self.policy_file)
                        continue
                    if set(policy_log_json[i]['domain']) == set(tmp_policy_dict[i]['domain']):
                        logging.info("policy " + i + " had no refresh ,no need to post")
                        policy_name.remove(i)
                else:
                    logging.info("new policy_dict : ")
                    logging.info(policy_log_json[i]['text'])
                    logging.info("old policy_dict : ")
                    logging.info(tmp_policy_dict[i]['text'])
        return policy_name




class InitNginxConf(threading.Thread):
    def __init__(self,queue):
        self.queue = queue
        threading.Thread.__init__(self)
    def run(self):
        global policy_dict
        while True:
            try:
                policy_name = self.queue.get_nowait()
            except:
                break
            if not policy_name:
                continue
            Ngx = Nginx()
            if policy_name == 'default':
                domain_nginx_conf = Ngx.get_nginx_conf(policy_name, policy_name)
                if domain_nginx_conf:
                    Ngx.write_conf_file(policy_name, domain_nginx_conf)
            else:
                if policy_dict[policy_name].has_key('domain'):
                    for domain in policy_dict[policy_name]['domain']:
                        domain_nginx_conf = Ngx.get_nginx_conf(policy_name, domain)
                        if domain_nginx_conf:
                            #文件名以域名为名字，其中的 . 换成 _
                            Ngx.write_conf_file(domain.replace(".", "_"), domain_nginx_conf)
                else:
                    logging.warning("fail:" + policy_name + " had no domain key")


class PostToNginx(threading.Thread):
    def __init__(self,queue):
        self.queue = queue
        threading.Thread.__init__(self)
    def run(self):
        global policy_dict
        while True:
            try:
                policy_name = self.queue.get_nowait()
            except:
                break
            if not policy_name:
                continue
            if policy_name == 'default':
                if policy_dict['default'].has_key('text'):
                    domain_json = policy_dict['default']['text']
                else:
                    logging.info(policy_name + ": no json to post")
                if domain_json:
                    post(json.dumps(domain_json))
                else:
                    logging.info(policy_name + ": no json to post")
            else:
                if policy_dict[policy_name].has_key('domain'):
                    for domain in policy_dict[policy_name]['domain']:
                        domain_json = copy.deepcopy(policy_dict[policy_name]['text'])
                        if domain_json:
                            domain_json['domain'] = domain
                            post(json.dumps(domain_json))
                else:
                    logging.info(policy_name + ": no domain to post")


class Nginx(object):
    def __init__(self):
        global nginx_sbin
        global nginx_conf_pwd
        global nginx_reload_try_time
        global nginx_node_hash_conf_name
        self.nginx_sbin = nginx_sbin
        self.nginx_conf_pwd = nginx_conf_pwd
        self.nginx_reload_try_time = nginx_reload_try_time
        self.nginx_node_hash_conf_name = nginx_node_hash_conf_name

    @property
    def is_new(self):
        #以边缘hash文件是否存在这个条件作为判断是否是新初始化设备的依据，新初始化的设备需要reload
        if not os.path.exists(self.nginx_conf_pwd + nginx_node_hash_conf_name):
            return True
        else:
            return False

    def check(self):
        global mutex
        excute_code = 1
        for i in range(self.nginx_reload_try_time):
            if mutex.acquire(1):
                try:
                    excute_code = os.system(self.nginx_sbin + " -t >/dev/null 2>&1 ")
                except:
                    logging.warning("nginx -t occur error...")
                finally:
                    mutex.release()
            if excute_code != 0:
                logging.warning("fail:nginx check failed "+str(i + 1))
                if i == self.nginx_reload_try_time - 1:
                    return False
            else:
                return True

    def reload(self):
        global mutex
        if self.is_new:
            logging.warning("new dev not init success,nginx no need reload")
            return False
        if self.check():
            for i in range(self.nginx_reload_try_time):
                excute_code = 1
                if mutex.acquire(1):
                    try:
                        excute_code = os.system(self.nginx_sbin + " -s reload")
                    except:
                        logging.warning("nginx reload occur error...")
                    finally:
                        mutex.release()
                    if excute_code != 0:
                        logging.warning("fail:nginx reload failed "+str(i + 1))
                        if i == self.nginx_reload_try_time - 1:
                            return False
                    else:
                        logging.info("success:nginx reload success")
                        return True
        else:
            logging.warning("fail:nginx check fail,can't reload")

    def write_conf_file(self,file_name,file_context):
        #写Nginx配置文件
        #需要写的配置文件跟已有的配置文件md5不一致才写
        #先把原来的配置文件复制一份到/tmp目录
        #然后把需要写的配置写到/tmp目录
        #覆盖原来的配置文件
        #nginx -t 测试，不成功就全部复原
        if 'node_backend' not in str(file_name):
            file_name = "ops_%s" % (file_name)
        nginx_file = self.nginx_conf_pwd + file_name + ".conf"
        tmp_nginx_file = "/tmp/%s.conf" % (file_name)
        tmp2_nginx_file = "/tmp/tmp_%s.conf" % (file_name)
        L = LogWriteTime(nginx_file)
        if not L.need_write:
            return True
        init_nginx_md5 = get_str_md5(file_context)
        if os.path.exists(nginx_file):
            with open(nginx_file) as file_obj:
                nginx_file_str = file_obj.read()
        else:
            nginx_file_str = ''
        nginx_md5 = get_str_md5(nginx_file_str)
        if nginx_md5 != init_nginx_md5:
            logging.info(file_name + " new config file md5 : " + init_nginx_md5 + " old config file md5 : " + nginx_md5)
            if os.path.exists(nginx_file):
                try:
                    shutil.copy(nginx_file,tmp_nginx_file)
                except:
                    logging.warning(file_name + " copy nginx file " + file_name + "failed")
            try:
                with open(tmp2_nginx_file,"w") as nginx_file_obj:
                    nginx_file_obj.write(str(file_context))
                    logging.info("success:" + file_name + " write nginx tmp conf success")
            except Exception:
                tb = traceback.format_exc()
                logging.warning(tb)
                logging.warning("fail:" + file_name + " write nginx tmp file failed")
                if self.is_new:
                    pass
#                    dev_not_post_to_g3()
                return False
            try:
                shutil.move(tmp2_nginx_file,nginx_file)
            except Exception:
                tb = traceback.format_exc()
                logging.warning(tb)
                logging.warning("fail:" + file_name + " move nginx file failed")
                if self.is_new:
                    pass
#                    dev_not_post_to_g3()
                return False
            if self.check():
                logging.info("success:write nginx file " + file_name)
                if self.is_new:
                    pass
#                    dev_post_to_g3()
                return True
            else:
                try:
                    logging.warning("fail:" + file_name + str(file_context))
                    shutil.move(tmp_nginx_file,nginx_file)
                except:
                    logging.warning("fail:" + file_name + " move nginx file " + file_name + "failed")
                if self.is_new:
                    pass
#                    dev_not_post_to_g3()
                return False
        else:
            logging.info(nginx_file + " same,no need write.new config file md5 : " + init_nginx_md5 + " old config file md5 : " + nginx_md5)
            if self.is_new:
                pass
#                dev_post_to_g3()
            return True

    def get_node_hash_conf(self):
        #返回边缘hash文件内容
        #一致性hash
        global policy_dict
        upstream_txt = 'upstream node_backend  {\n    hash $cohash_key consistent;\n    keepalive 500;'
        ats_upstream_txt = 'upstream ats_node_backend  {\n    hash $cohash_key;\n    keepalive 500;'
        try:
            policy_name = policy_dict.keys()[0]
        except:
            logging.warning(policy_dict)
            logging.warning("fail:get_node_hash_conf: get represent policy fail...")
            return False
        if policy_dict[policy_name]['text']['myhostlist'] == []:
            logging.warning("fail:can't get node info from g3...")
            return False
        for i in policy_dict[policy_name]['text']['myhostlist']:
            upstream_txt = "%s\n    server %s max_fails=0;" % (upstream_txt,i['hostip'])
            ats_upstream_txt = "%s\n    server %s:18980 max_fails=0;" % (ats_upstream_txt, i['hostip'])
        upstream_txt = "%s\n}\n" % (upstream_txt)
        ats_upstream_txt = "%s\n}\n" % (ats_upstream_txt)
        if upstream_txt  and ats_upstream_txt:
            return [upstream_txt, ats_upstream_txt]
        else:
            logging.warning("fail:get node hash conf fail...")
            return False

    def get_nginx_conf(self, policy_name, domain):
        #返回域名回源upstream配置文件内容
        #policy 0 顺序
        #policy 1 随机
        global policy_dict
        upstream_txt = ''
        tmp = 1
        use_node = []
        if not policy_dict.has_key(policy_name):
            return False
        if not policy_dict[policy_name].has_key('text'):
            return False
        if not policy_dict[policy_name]['text'].has_key('policy'):
            return False
        try:
            policy_type_int = policy_dict[policy_name]['text']['policy']
        except:
            policy_type_int = 0
        if policy_type_int == 0:
            policy_type = 'roundrobin'
        elif policy_type_int == 1:
            policy_type = 'random'
        else:
            policy_type = 'roundrobin'
        if not policy_dict[policy_name]['text'].has_key('sourcelist'):
            return False
        if policy_dict[policy_name]['text']['sourcelist'] == []:
            logging.warning(policy_name + " : " + domain + " can't get source info from g3...")
            return False
        for i in policy_dict[policy_name]['text']['sourcelist']:
            upstream_txt = '%supstream  %s_%s_%s {\n    hash $uri;\n    keepalive 500;' % (upstream_txt, domain, policy_type,tmp)
            use_node.append(i.keys())
            for j in i[i.keys()[0]]:
                upstream_txt = "%s\n    server %s;" % (upstream_txt,j['hostip'])
            upstream_txt = "%s\n}\n" % (upstream_txt)
            tmp += 1
        if upstream_txt:
            logging.info("write_nginx_file :" + policy_name + ":" + domain + ":" + str(use_node))
            return upstream_txt
        else:
            logging.warning("fail:get nginx conf fail " + policy_name + " " + domain )
            return False

    def write_all_nginx_conf(self):
        global nginx_write_thread_num
        global policy_dict
        node_hash_conf = self.get_node_hash_conf()
        if node_hash_conf:
            self.write_conf_file(self.nginx_node_hash_conf_name.split(".")[0], node_hash_conf[0])
            self.write_conf_file('ops_ats_node_backend', node_hash_conf[1])
        else:
            logging.warning("fail:write nginx node hash conf file fail...")
        queue=Queue.Queue()
        threads=[]
        if policy_dict == {}:
            logging.warning("fail:no info to write...")
            exit_script_warnning()
        for i in policy_dict:
            if not i:
                continue
            queue.put(i)
        for _ in range(nginx_write_thread_num):
            t = InitNginxConf(queue=queue)
            try:
                t.setDaemon(True)
            except Exception:
                tb = traceback.format_exc()
                logging.warning(tb)
                return False
            t.start()
            threads.append(t)
        while True:
            isAlive = False
            for t in threads:
                isAlive = isAlive or t.isAlive()
            if not isAlive:
                break
            time.sleep(1)
        return True

    def post_all_domain(self):
        global nginx_post_thread_num
        global policy_dict
        if policy_dict == {}:
            logging.warning("fail:no info to post...")
            exit_script_warnning()
        P = Policy()
        need_post_policy = P.need_post_policy
        if not need_post_policy:
            return False
        queue=Queue.Queue()
        threads=[]
        for i in need_post_policy:
#        for i in policy_dict:
            if not i:
                continue
            queue.put(i)
        for _ in range(nginx_post_thread_num):
            t = PostToNginx(queue=queue)
            try:
                t.setDaemon(True)
            except Exception:
                tb = traceback.format_exc()
                logging.warning(tb)
                return False
            t.start()
            threads.append(t)
        while True:
            isAlive = False
            for t in threads:
                isAlive = isAlive or t.isAlive()
            if not isAlive:
                break
            time.sleep(1)
        return True


def main():
    usage = "usage: %prog [options] -c /usr/local/nginx/get_source.conf"
    parser = optparse.OptionParser(usage=usage)
    parser.add_option('-c','--config',dest='config',type=str,default='/usr/local/nginx/get_source.conf',help='config file path')
    options,args = parser.parse_args()
    config_file = options.config
    conf = ConfigParser.ConfigParser()
    conf.read(config_file)
    #初始化全局变量
    global pid_file
    if conf.has_option('Common','pid_file'):
        pid_file = conf.get("Common", "pid_file")
    else:
        pid_file = '/tmp/get_source.pid'
    global del_pid_file_time
    if conf.has_option('Common','del_pid_file_time'):
        del_pid_file_time = conf.getint("Common", "del_pid_file_time")
    else:
        del_pid_file_time = 7200
    global policy_log_file
    if conf.has_option('Common','policy_log_file'):
        policy_log_file = conf.get("Common", "policy_log_file")
    else:
        policy_log_file = '/tmp/last_policy_dict.json'
    global g3_url
    try:
        if conf.has_option('Common','g3_url'):
            g3_url1 = conf.get("Common", "g3_url")
            g3_url = eval(g3_url1)
        else:
            g3_url = ['http://api.gslb.letv.com/api/source', 'http://g3.letv.cn/source', 'http://coop.gslb.letv.com/api/source', 'http://bak1.coop.gslb.letv.com/api/source']
    except:
        g3_url = ['http://api.gslb.letv.com/api/source', 'http://g3.letv.cn/source', 'http://coop.gslb.letv.com/api/source', 'http://bak1.coop.gslb.letv.com/api/source']
    global nginx_sbin
    if conf.has_option('Nginx','nginx_sbin'):
        nginx_sbin = conf.get("Nginx", "nginx_sbin")
    else:
        nginx_sbin = '/usr/local/nginx/sbin/nginx'
    global nginx_conf_pwd
    if conf.has_option('Nginx','nginx_conf_pwd'):
        nginx_conf_pwd = conf.get("Nginx", "nginx_conf_pwd")
    else:
        nginx_conf_pwd = '/usr/local/nginx/conf/opscfg/'
    global nginx_reload_try_time
    if conf.has_option('Nginx','nginx_reload_try_time'):
        nginx_reload_try_time = conf.getint("Nginx", "nginx_reload_try_time")
    else:
        nginx_reload_try_time = 3
    global nginx_node_hash_conf_name
    if conf.has_option('Nginx','nginx_node_hash_conf_name'):
        nginx_node_hash_conf_name = conf.get("Nginx", "nginx_node_hash_conf_name")
    else:
        nginx_node_hash_conf_name = 'ops_node_backend.conf'
    global nginx_api
    if conf.has_option('Nginx','nginx_api'):
        nginx_api = conf.get("Nginx", "nginx_api")
    else:
        nginx_api = 'http://127.0.0.1/api/ups_config'
    global nginx_write_time
    if conf.has_option('Nginx','nginx_write_time'):
        nginx_write_time = conf.getint("Nginx", "nginx_write_time")
    else:
        nginx_write_time = 3600
    global nginx_write_thread_num
    if conf.has_option('Nginx','nginx_write_thread_num'):
        nginx_write_thread_num = conf.getint("Nginx", "nginx_write_thread_num")
    else:
        nginx_write_thread_num = 10
    global nginx_post_thread_num
    if conf.has_option('Nginx','nginx_post_thread_num'):
        nginx_post_thread_num = conf.getint("Nginx", "nginx_post_thread_num")
    else:
        nginx_post_thread_num = 10
    global get_group_thread_num
    if conf.has_option('Nginx','get_group_thread_num'):
        get_group_thread_num = conf.getint("Nginx", "get_group_thread_num")
    else:
        get_group_thread_num = 10
    logging.basicConfig(level=logging.DEBUG,
                        format='%(asctime)s %(levelname)s %(message)s',
                        datefmt='%Y-%m-%d %H:%M:%S',
                        filename='/tmp/get_source_' + datetime.datetime.now().strftime("%m") + '.log',
                        filemode='a')
    if os.path.exists(pid_file):
        pid_c_time = int(os.path.getctime(pid_file))
        pid_c_before = int(time.time()) - pid_c_time
        #pid文件创建于配置的时间之前的话，删除掉
        if pid_c_before > del_pid_file_time:
            os.remove(pid_file)
        else:
            logging.warning("check_front still running")
            sys.exit(1)
    pid = os.getpid()
    with open(pid_file,'w') as pid_file_obj:
        pid_file_obj.write(str(pid))
    global need_reload
    global mutex
    global policy_dict
    policy_dict = {}
    mutex = threading.Lock()
    G3 = G3Interface()
    all_domain = G3.get_all_domain()
    G3.get_group_info()
    Ngx = Nginx()
    Pol = Policy()
    #如果是刚初始化的设备，先写配置文件，然后reload
    need_reload = Ngx.is_new
    if need_reload:
        logging.info("new dev, need write nginx config and reload")
        Ngx.write_all_nginx_conf()
        Ngx.reload()
    #以上次写配置文件的时间判断本次是否需要写配置文件
    Ngx.write_all_nginx_conf()
    #post到nginx接口
    Ngx.post_all_domain()
    #记录本次的所有group内容
    Pol.log_policy()
    exit_script()




if __name__ == '__main__':
    #增加随机数，避免调度压力大
    time.sleep(random.randint(0,30))
    main()

