#!/usr/bin/env python
#coding: utf-8
# (c) 2015 , Shichao Gao <gaoshichao@letv.com>
#
# 该脚本用于检查cto加速通道的状态
#
# 版本: 1.3.20150804
##############################################################################
import os,sys
import time
import subprocess
import signal
import re
import commands
from multiprocessing import Process

# [LOG]
LOG_FILE = "/dev/shm/.checkcto.log"
FILENAME = __file__.split('.')[0].split('/')[-1]
PID = os.getpid()
PID_PATH = "/tmp/"+FILENAME+".pid"
FORMAT_TIME = "%Y-%m-%d %H:%M:%S"
FORMAT_LOG = "[%(local_time)s][%(level)s][%(pid)s] %(log)s \n"

# [CTO]
CTO_FILE_LIST = ["/cto/bin/ctocmd","/cto/bin/ctostart"]
CODE_FILE = "/cto/cto.status"
PORT_BAND = 80       # 测速下载端口
TIMEOUT_BAND = 10    # 下载测速文件超时时间(s)         
RETRY_BAND = 3       # 下载一个测速文件重试次数              
TIMEOUT_SHELL = 15   # shell运行超时时间(s)
RESTART_SLEEP = 30   # 重启CTO后的等待时间
WHITE_IP_LIST = ['221.204.206.98', '221.204.206.99', '221.204.206.100', '221.204.206.101', '221.204.206.110', '221.204.206.111', '221.204.206.207', '221.204.206.208', '221.204.206.209', '221.204.206.210', '221.204.206.211', '221.204.206.236', '221.204.206.237', '221.204.206.238']    # 白名单IP，不需要探测的对端IP

def write_log(level, log):
    """
    记录日志到文件
        参数：
        log   - 日志信息
    """
    log_mess_dict = {
        'local_time' : time.strftime(FORMAT_TIME,time.localtime(time.time())) ,
        'level'      : level ,
        'pid'        : PID ,
        'log'        : log
    }
    log_mess = FORMAT_LOG %log_mess_dict 
    with open(LOG_FILE, 'a') as f:
        f.write(log_mess)

def error_log(log):
    write_log("error", log)

def trace_log(log):
     write_log("trace", log)

class CheckCTO():
    """CTO 检测类"""
    def __init__(self):
        self.cto_file_list = CTO_FILE_LIST;     # CTO 文件列表（为确认CTO是否安装）
        self.code = 0                           # CTO状态，默认为0（正常）
        """
        Status    Information
         -3         状态未知
         -2         检查脚本正在运行
         -1         没有CTO相关文件
          0         CTO服务正常
          1         CTO已安装，部分通道状态不是Established
          2         CTO异常，重启CTO，启动失败
          3         CTO异常，重启CTO，启动成功，部分通道状态不是Established
          4         CTO异常，重启CTO，启动成功，通道状态正常，探测80端口失败
          5         CTO异常，重启CTO，启动成功，通道状态正常，探测80端口成功
          6         CTO异常，重启CTO，启动成功，查询通道timeout
        """
        self.cto_installed = True;              # CTO是否安装，默认是True（已安装）
        self.all_status = []                    # CTO通道状态汇总
        self.resign = 0                         # 重启CTO标识
    
    def checkinstall(self):
        """检测CTO是否安装"""
        for file in self.cto_file_list:
            if not os.path.exists(file):
                self.cto_installed = False;

    def getchannels(self):
        """获取所有通道信息"""
        self.all_status = []           # 每次执行前，需要清空之前获取的通道信息
        cmd = "/cto/bin/ctocmd -client -channelstatus"
        ret, stdout, stderr, poll = shell_run(cmd)
        str_lchannels = stdout

        if str_lchannels.find("No channel data in packet") == 0: #未获取到频道信息
            return -1 

        if str_lchannels.find("Request timeout") == 0:  	 #获取频道timeout
            return -2
        
        re_format = "Stat:(?P<status>\w+)[^\n]*\n\s*Peer:(?P<ip>[^:]*):"
        reg = re.compile(re_format)
        for i in reg.finditer(str_lchannels):
            self.all_status.append(i.groupdict())
        for i in self.all_status:  #剔除白名单IP
            if i['ip'] in WHITE_IP_LIST:
                num = self.all_status.index(i)
                self.all_status.pop(num)
        return 0

    def restartcto(self):
        """重启CTO"""
        cmd = "/cto/bin/ctorestart"
        #ret, stdout, stderr = shell_run(cmd)
        #ret = commands.getstatusoutput(cmd)[0]
        ret = os.system(cmd)  #并卵用
        return ret

    def startcheck(self, restartsleep=RESTART_SLEEP):
        """开始检查所有通道"""

        """检测状态是否Established"""
        msg = []
        for i in self.all_status:
            if i['status'] != "Established":
                self.code = 1
                msg.append("%s:%s" % (i['ip'],i['status']))
        if len(msg) != 0:
            str_msg = ','.join(msg) 
            trace_log("error status: %s" %str_msg)

        """下载Established通道的测速文件,如下载失败，则重启CTO""" 
        lp = []                 # 子进程列表
        lexitcode = []          # 子进程退出值，根据此判断是否下载正常
        for i in self.all_status:
            if i['status'] == "Established": 
                p = Process(target=checkdownload, name=i['ip'], args=(i['ip'],))
                p.start()
                lp.append(p)

        for p in lp:   # for循环下，join后面的命令相当于放入后台，阻塞的子进程执行完毕后运行
            p.join()
            trace_log('%s.exitcode = %s' % (p.name, p.exitcode))
            lexitcode.append(p.exitcode)

        for code in lexitcode:
            if code != 0:
                self.resign = 1

        if self.resign == 1:
            ret = self.restartcto()
            if ret != 0:         #重启失败
                self.code = 2
                return self.code
            else:                #重启成功
                trace_log("restart cto success,start sleep %ss..." %restartsleep)
                time.sleep(restartsleep)
                trace_log("reget the channels info ...")
                ret = self.getchannels()
                if ret == -1:
                    error_log("after restart cto, can't find channels.")
                    self.code = -3
                    return self.code
                elif ret == -2:
                    error_log("after restart cto, check cto timeout.")
                    self.code = 6 
                    return self.code
                else:
                    trace_log("start second check...")
                    self.secondcheck()
                    return self.code
        return self.code

    def dealtimeout(self, restartsleep=RESTART_SLEEP):
        """查询通道timeout后，处理"""
        ret = self.restartcto()
        if ret != 0:
            self.code = 2 
        else:
            trace_log("restart cto success,start sleep %ss..." %restartsleep)
            time.sleep(restartsleep)
            trace_log("reget the channels info ...")
            ret = self.getchannels()
            if ret == -1:
                error_log("after restart cto, can't find channels.")
                self.code = -3
            elif ret == -2:
                error_log("after restart cto, check cto timeout.")
                self.code = 6 
            else:
                trace_log("start second check...")
                self.secondcheck()
        return self.code

    def secondcheck(self):
        """重启后，第二次检测"""

        #第二次不需要检测状态，只要保证服务正常即可,邮件会通知
        #"""检测状态是否Established"""
        #for i in self.all_status:
        #    if i['status'] != "Established":
        #        self.code = 3 
        #        pass

        """下载Established通道的测速文件"""
        lp = []
        lexitcode = []
        for i in self.all_status:
            if i['status'] == "Established":
                p = Process(target=checkdownload, name=i['ip'], args=(i['ip'],))
                p.start()
                lp.append(p)

        for p in lp:
            p.join()
            trace_log('%s.exitcode = %s' % (p.name, p.exitcode))
            lexitcode.append(p.exitcode)

        for code in lexitcode:
            if code != 0:
                self.code = 4
                return
        self.code = 5
                        
def shell_run(command, timeout=TIMEOUT_SHELL):
    """
    运行shell命令，调用subprocess.Popen，支持timeout
    """
    wait_seconds = 0.5
    deadline = time.time() + timeout
    #proc = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, preexec_fn = os.setsid) #这个测试也可以
    proc = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, preexec_fn = os.setpgrp)
    trace_log("run command: \"%s\", pid is %s, gpid is %s." %(command,proc.pid,os.getpgid(proc.pid)) )
    while time.time() < deadline and proc.poll() == None:
        time.sleep(wait_seconds)
    if proc.poll() == None:  # normal is 0
        error_log("cmd [%s] \"%s\" is hunging...,now kill it.. poll: %s." %(proc.pid,command,proc.poll()) )
        os.killpg(proc.pid, signal.SIGUSR1)
    elif proc.poll() > 0:
        error_log("cmd [%s] \"%s\" run failed! poll: %s." %(proc.pid,command,proc.poll()) )

    stdout,stderr = proc.communicate()

    return proc.returncode,stdout,stderr,proc.poll()

def checkdownload(ip, port=PORT_BAND, timeout=TIMEOUT_BAND, retry=RETRY_BAND):
    """下载1k测速文件"""
    for _ in range(RETRY_BAND):
        cmd = "curl --connect-timeout %s -so /dev/null http://%s:%d/letvabcdeasktf1k" % (timeout, ip, port) 
        ret, stdout, stderr, poll = shell_run(cmd)
        if poll == 0:
            return
    sys.exit(1) 

def code2file(code, file=CODE_FILE):
    """将code值写入文件"""
    dir = os.path.dirname(file)
    if not os.path.exists(dir):
       os.makedirs(dir) 
    with open(file, 'w') as f:
        f.write(str(code)) 
    trace_log("code %d is writen in %s." %(code,file) )
    

if __name__ == "__main__":
    
    #每天00:00清除log日志
    now = time.strftime("%H:%M", time.localtime(time.time()))
    if now == "00:00":
        shell_run("cat /dev/null >%s" %LOG_FILE)

    #建立pid文件
    if os.path.exists(PID_PATH):
        trace_log("%s already exists!" %PID_PATH )
        code2file(-2)
        sys.exit()
    with open(PID_PATH, 'w') as pidfile:
        pidfile.write("%s" %PID)
         
    #开始检查CTO
    try:
        cto = CheckCTO() 
        cto.checkinstall()
        if cto.cto_installed == True:
            trace_log("CTO is already installed.")
        else:
            error_log("CTO is not installed. exit..")
            code2file(-1)
            sys.exit()

        ret = cto.getchannels()
        if ret == -1:
            trace_log("CTO has no channels. exit...")
        elif ret == -2:
            trace_log("get channels timeout. restart cto...")            
            cto.dealtimeout()
        else: 
            cto.startcheck()

        if cto.code == 0:
            trace_log("CTO is normal!")
        code2file(cto.code)

    except SystemExit:
        pass

    except BaseException,e:
        error_log(e)
        code = -3
        code2file(code) 

    finally:
        os.remove(PID_PATH)
