#!/usr/bin/env python
#coding: utf-8
# (c) 2015 , Shichao Gao <gaoshichao@letv.com>
#
# 该脚本用于检查crtmpserver状态
#
# 版本: 1.3.20151125
##############################################################################
import os,sys
import time,datetime
import socket
import subprocess
import signal
import re
import commands
from multiprocessing import Process
import json

# [LOG]
LOG_FILE = "/dev/shm/.checkcrs.log"
LOG_SAVE_DAY = 3
END_LINE = (datetime.datetime.now() - datetime.timedelta(days=LOG_SAVE_DAY)).strftime('%Y%m%d')
OLD_LOG_FILE = LOG_FILE+"_"+END_LINE
FILENAME = __file__.split('.')[0].split('/')[-1]
PID = os.getpid()
PID_PATH = "/var/run/"+FILENAME+".pid"
FORMAT_TIME = "%Y-%m-%d %H:%M:%S"
FORMAT_LOG = "[%(local_time)s][%(level)s][%(pid)s] %(log)s \n"

# [CRS]
CRS_FILE_LIST_CDN = ["/usr/local/sbin/crtmpserver","/usr/local/etc/crtmpserver.cdn.lua"]
CRS_FILE_LIST_LIVE = ["/opt/project/crtmpserver/bin/crtmpserver","/opt/project/crtmpserver/conf/crtmpserver.lua"]
CODE_FILE = "/usr/local/zabbix/tmp/lers.status"
CRS_PID_FILE = "/var/run/crtmpserver.pid"
CCAPI_TIMEOUT = 5
CCAPI_RETRY = 2   #重试2次，共3次
START_INFO_FILE = "/dev/shm/crs.start.info"   #crs启动信息 
RESTART_THRESHOLD = 1800              #重启阈值半个小时
NGINX_RTMP_CONF = "/usr/local/nginx/conf/letv/rtmp.conf"    #nginx rtmp的配置文件

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

class CheckCRS():
    """CRS 检测类"""
    def __init__(self,role):
        if role == 1:
            self.crs_file_list = CRS_FILE_LIST_LIVE
        elif role == 2:
            self.crs_file_list = CRS_FILE_LIST_CDN
        self.code = 0                          # CRS状态，默认为0（正常）
        """
        Status    Information
         -3         状态未知
         -2         检查脚本正在运行
         -1         未安装,没有CRS相关文件
          0         CRS服务正常
          1         进程未正常运行
          2         直播控制中心API访问异常
          3         PID实时修改时间
          4         30分钟(RESTART_THRESHOLD)内重启次数大于等于2次
          5         多进程模式下,CRS进程数和NGINX配置进程数不符
        """
        self.installed = True;              # CRS是否安装，默认是True（已安装）
        self.version = None 

        #多进程模式判断
        #cmd = "netstat -tnlp | grep -w 1935 | grep -q crtmpserver"
        cmd = "ps -ef | grep -v grep | grep -q crtmpserver.pid"
        ret = commands.getstatusoutput(cmd)[0]
        if ret == 0 :
            self.mode = 1                   # 单进程模式
            self.pids = []                  # 多进程模式下，pid汇总
            self.ports = []                 # 多进程模式下，port汇总  
        else:
            self.mode = 2                   # 多进程模式
            self.pids = commands.getstatusoutput("/sbin/pidof crtmpserver")[1].split()
            conf2string = commands.getoutput("cat %s" %NGINX_RTMP_CONF)
            self.ports = [ s.group().replace(':','') for s in re.finditer(r':19\d+',conf2string) ]
             
    def checkinstall(self):
        """检测CRS是否安装"""
        for file in self.crs_file_list:
            if not os.path.exists(file):
                self.installed = False; 
                self.code = -1
                return -1
        self.version = commands.getstatusoutput("%s --version | grep Version" %self.crs_file_list[0] )[1].split()[1] 
        return 0

    def checkproc(self):
        """检测当前CRS进程是否正常"""
        cmd = "/sbin/pidof crtmpserver"
        ret = commands.getstatusoutput(cmd)        
        if ret[0] != 0:
            self.code = 1 
        return ret[0]
            
    def checkccapi(self,timeout=CCAPI_TIMEOUT,retry=CCAPI_RETRY):
        """检测直播控制中心接口"""
        cmd = "curl --retry %s --connect-timeout %s -so /dev/null http://api.live.letv.com/noc.gif" %(retry, timeout)
        ret = commands.getstatusoutput(cmd)
        if ret[0] != 0:
            self.code = 2
        return ret[0]

    def checkpid(self,pidfile=CRS_PID_FILE):
        """检测pid是否正常更新"""
        mtime = time.time() - os.stat(pidfile).st_mtime 
        if mtime > 180 :   #修改时间间隔大于3分钟
            self.code = 3 
            return -1 
        return 0

    def checkmultinum(self,nginx_rtmp_conf=NGINX_RTMP_CONF):
        """检测进程数量和NGINX配置文件是否相符"""
        nginx_pids_count = int(commands.getstatusoutput("grep -v ^# %s | grep 'server 127.0.0.1:' |wc -l" %nginx_rtmp_conf)[1])
        if len(self.pids) != nginx_pids_count:
            self.code = 5
            return -1
        else:
            return 0

    def getcrsruntime(self,pid):
        """获取单个CRS进程运行时间"""
        user_hz = commands.getstatusoutput("getconf CLK_TCK")[1]
        jiffies = commands.getstatusoutput("cat /proc/%s/stat | cut -d\" \" -f22" %pid)[1]
        sys_uptime = commands.getstatusoutput("cat /proc/uptime | cut -d\" \" -f1")[1]
        crsruntime = int(float(sys_uptime)) - int(jiffies)/int(user_hz)
        return crsruntime

    def checkrestartcount(self,pid,port='1935'):
        """检测重启阈值"""
        start_info_file = START_INFO_FILE+'.'+port;
        trace_log("Start checking: %s." %start_info_file)
        runtime = self.getcrsruntime(pid)
        startinfo = {'pid':pid, 'runtime':runtime }
        trace_log("Getted startinfo: %s." %startinfo)
        fileinfo = {} 
        if os.path.exists(start_info_file):
            tmp = commands.getstatusoutput("cat %s" %start_info_file)[1]
            if len(tmp) != 0:
                fileinfo = json.loads(json.dumps(eval(tmp)))
                trace_log("Getted fileinfo: %s." %fileinfo)
        if not os.path.exists(start_info_file) or len(fileinfo) == 0: #第一次运行或者start_info_file没有内容，需要建立文件并写入当前信息
            trace_log("%s is not exists.setup and write." %start_info_file)
            with open(start_info_file, 'w') as f:
                f.write(str(startinfo))
            return 0
        else: #文件存在且有信息，需要对比信息
            if startinfo['pid'] == fileinfo['pid']:  #pid相同，更新runtime
                trace_log("pid is same,update runtime.")
                with open(start_info_file, 'w') as f:
                    f.write(str(startinfo))
                return 0
            elif fileinfo['runtime'] > RESTART_THRESHOLD: #pid不同，runtime大于阈值也要更新       
                trace_log("runtime is %s,more than threshold: %s."%(fileinfo['runtime'],RESTART_THRESHOLD))
                with open(start_info_file, 'w') as f:
                    f.write(str(startinfo))
                return 0
            elif fileinfo['runtime'] < RESTART_THRESHOLD: #pid不同，runtime小于阈值也要更新
                error_log("runtime is %s,less than threshold: %s."%(fileinfo['runtime'],RESTART_THRESHOLD))
                with open(start_info_file, 'w') as f:
                    f.write(str(startinfo))
                self.code = 4
                return -1
                
def code2file(code, file=CODE_FILE):
    """将code值写入文件"""
    dir = os.path.dirname(file)
    if not os.path.exists(dir):
       os.makedirs(dir)
    with open(file, 'w') as f:
        f.write(str(code))
    trace_log("code %d is writen in %s." %(code,file) ) 
    
if __name__ == "__main__":
    
    #每天00:15新建log日志,并删除旧的日志
    now = time.strftime("%H:%M", time.localtime(time.time()))
    if now == "00:15":
        yes_time = (datetime.datetime.now() - datetime.timedelta(days=1)).strftime('%Y%m%d')
        os.rename(LOG_FILE,LOG_FILE+"_"+yes_time)
    if os.path.exists(OLD_LOG_FILE):
       os.remove(OLD_LOG_FILE)

    #建立pid文件
    if os.path.exists(PID_PATH):
        trace_log("%s already exists!" %PID_PATH )
        code2file(-2)
        sys.exit()
    with open(PID_PATH, 'w') as pidfile:
        pidfile.write("%s" %PID)
         
    #开始检查CRO
    try:
        #检测本机为LIVE点 or CDN点, 1/LIVE 2/CDN
        if re.match(r'LIVE-.*',socket.gethostname()): 
            trace_log("The host role is: LIVE.")
            role = 1
        else:
            trace_log("The host role is: CDN.")
            role = 2

        crs = CheckCRS(role) 
        #检测是否安装CRS
        crs.checkinstall()
        if crs.installed == True:
            trace_log("CRS is already installed.")
        else:
            error_log("CRS is not installed. exit..")
            code2file(crs.code)
            sys.exit()

        #检测进程是否在运行
        ret = crs.checkproc()
        if ret == 0:
            trace_log("CRS progress is running.")
        else:
            error_log("CRS progress is not running, exit...")
            code2file(crs.code)
            sys.exit(1)

        #检测直播控制中心API接口是否正常 
        ret = crs.checkccapi()
        if ret == 0:
            trace_log("Get ccapi success.")
        else:
            error_log("Get ccapi failed, exit...")
            code2file(crs.code)
            sys.exit(1)

        #版本低于1.1-2833的暂不检测        
        if crs.version.split('-')[0] == '1.1' and int(crs.version.split('-')[1]) < 2833:
            trace_log("CRS version is lower than 1.1-2833,exit...") 
            code2file(0)
            sys.exit(0)

        if crs.mode == 1:    # 单进程模式检测 
            trace_log("CRS in running in single process mode.")
            #检测进程是否有卡死，正常情况下pid文件1分钟更新一次 
            ret = crs.checkpid(CRS_PID_FILE)
            if ret == 0:
                trace_log("The pid file is updating.")
            else:
                error_log("The pid file hasn't updated for 3 minutes,exit...")
                code2file(crs.code)
                sys.exit(1)
        
            #检测进程在30分钟内是否有重启
            pid = commands.getstatusoutput("cat %s" % CRS_PID_FILE)[1]
            ret = crs.checkrestartcount(pid)
            if ret != 0:
                error_log("Restart 2 times in %s seconds." %RESTART_THRESHOLD)
                code2file(crs.code)
                sys.exit(1)
        else:               # 多进程模式检测
            trace_log("CRS in running in multi process mode.")
            #检测进程数量和NGINX配置文件是否相符
            ret = crs.checkmultinum()
            if ret == 0:
                trace_log("There are %s process is runnning: %s." %(len(crs.pids),crs.pids))
            else:
                error_log("Running process number is not the same as %s."%NGINX_RTMP_CONF)
                code2file(crs.code)
                sys.exit(1)
    
            #检测进程是否有卡死，正常情况下pid文件1分钟更新一次 
            for oneport in crs.ports:
                pidfile = "/var/run/crtmpserver.%s.pid" %oneport;
                ret = crs.checkpid(pidfile)
                if ret == 0:
                    trace_log("The pid file %s is updating." %pidfile)
                else:
                    error_log("The pid file hasn't updated for 3 minutes,exit...")
                    code2file(crs.code)
                    sys.exit(1)

            #检测进程在30分钟内是否有重启
            for oneport in crs.ports:
                pidfile = "/var/run/crtmpserver.%s.pid" %oneport;
                pid = commands.getoutput("cat %s" %pidfile)
                ret = crs.checkrestartcount(pid,oneport)
                if ret != 0:
                    error_log("Restart 2 times in %s seconds." %RESTART_THRESHOLD)
                    code2file(crs.code)
                    sys.exit(1)

        #正常
        code2file(crs.code)
    except SystemExit:
        pass

    except BaseException,e:
        error_log(e)
        code = -3
        code2file(code) 

    finally:
        os.remove(PID_PATH)
