#!/usr/bin/env python
#coding: utf-8
# (c) 2015 , Shichao Gao <gaoshichao@letv.com>
#
# 该脚本用于检查lers状态
#
# 版本: 1.6.20160703
# 目前角色: live clive cdn front store cloud newcdn
# 目前支持：cdn clive
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
import urllib
import urllib2

# [LOG]
LOG_FILE            = "/dev/shm/.checklers.log"
LOG_SAVE_DAY        = 3
END_LINE            = (datetime.datetime.now() - datetime.timedelta(days=LOG_SAVE_DAY)).strftime('%Y%m%d')
OLD_LOG_FILE        = LOG_FILE+"_"+END_LINE
FILENAME            = __file__.split('.')[0].split('/')[-1]
PID                 = os.getpid()
PID_PATH            = "/var/run/"+FILENAME+".pid"
FORMAT_TIME         = "%Y-%m-%d %H:%M:%S"
FORMAT_LOG          = "[%(local_time)s][%(level)s][%(pid)s] %(log)s \n"

# [LERS]
CODE_FILE            = "/usr/local/zabbix/tmp/lers.status"
LERS_PID_FILE        = "/var/run/lers.pid"
R2H_PID_FILE         = "/var/run/r2h.pid"
PIDMODTIME_THRESHOLD = 180  #pid修改时间180s/3分钟 
#CCAPI               = "http://api.live.letvcloud.com/noc.gif"
CCAPI                = "http://api.live.letv.com/noc.gif"
CCAPI_TIMEOUT        = 5
CCAPI_RETRY          = 2    #重试2次，共3次
LERS_START_INFO_FILE = "/dev/shm/lers.start.info"   #lers启动信息 
R2H_START_INFO_FILE  = "/dev/shm/r2h.start.info"    #r2h启动信息 
RESTART_THRESHOLD    = 1800 #重启阈值半个小时
LERS_CDN_CONF        = "/usr/local/etc/lers.cdn.lua"              #lers cdn 配置文件
LERS_PROXY_CDN_CONF  = "/usr/local/etc/lers_proxy.cdn.conf"       #lers proxy cdn 配置文件
LERS_LIVE_CONF       = "/opt/project/lers/conf/lers.lua"          #lers live 配置文件
LERS_PROXY_LIVE_CONF = "/opt/project/lers/conf/lers_proxy.conf"   #lers proxy live 配置文件

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

def conn_try_again(function):
    """http连接有问题时，自动重连"""
    RETRIES = 0 
    #重试的次数
    count = {"num": RETRIES}
    def wrapped(*args, **kwargs):
        try:
            return function(*args, **kwargs)
        except Exception, err:
            if count['num'] < 2:
                count['num'] += 1
                return wrapped(*args, **kwargs)				  
            else:
                raise Exception(err)
        return wrapped

class CheckLERS():
    """LERS 检测类"""
    def __init__(self):
        #检测本机为LIVE点 or CDN点, 1/LIVE 2/CDN
        if re.match(r'LIVE-.*',socket.gethostname()):
            trace_log("The host role is: LIVE.")
            self.role = 1
        else:
            trace_log("The host role is: CDN.")
            self.role = 2

        self.code = 0  # LERS状态，默认为0（正常）
        """
        Status    Information
         -3         状态未知
         -2         检查脚本正在运行
         -1         未安装,没有LERS相关文件
          0         LERS服务正常
          1         进程未正常运行
          2         直播控制中心API访问异常
          3         PID实时修改时间
          4         30分钟(RESTART_THRESHOLD)内重启次数大于等于2次
          5         LERS进程数和配置文件进程数不符
          6         LERS/R2H进程CPU利用率达到100%
          7         LERS/R2H进程MEM使用达到5G
        """
        self.installed = True;              # LERS是否安装，默认是True（已安装）
        self.version = None 

        #根据role获取pids ports
        if self.role == 1: # LIVE设备
            cmd ="ps -ef | grep 'rtmp port' | grep -v grep | awk -F [:\)] '{print $(NF-1)}'"
            ret = commands.getstatusoutput(cmd)[1].strip()
            # rtmp port汇总
            self.rtmpports = ret.split('\n')
            # rtmp pid汇总
            self.rtmppids  = [ commands.getstatusoutput("cat /var/run/lers.%s.pid"%port)[1].strip() for port in self.rtmpports ]

        elif self.role == 2: # CDN设备
            cmd ="ps -ef | grep 'rtmp port' | grep -v grep | awk -F [:\)] '{print $(NF-1)}'"
            ret = commands.getstatusoutput(cmd)[1].strip()
            # rtmp port汇总
            self.rtmpports = ret.split('\n')
            # rtmp pid汇总
            self.rtmppids  = [ commands.getstatusoutput("cat /var/run/lers.%s.pid"%port)[1].strip() for port in self.rtmpports ]

            cmd ="ps -ef | grep 'rtmp2http' | grep -v grep | awk -F [:\)] '{print $(NF-1)}'"
            ret = commands.getstatusoutput(cmd)[1].strip()
            # rtmp2http port汇总
            self.r2hports  = ret.split('\n') 
            # rtmp2http pid汇总
            self.r2hpids   = [commands.getstatusoutput("cat /var/run/r2h.%s.pid"%port)[1].strip() for port in self.r2hports ]
             
    def checkinstall(self):
        """检测LERS是否安装"""
        if self.role == 1: # LIVE 
            self.lers_file_list = ["/opt/project/lers/bin/lers", "/opt/project/lers/conf/lers.lua", "/opt/project/lers/bin/lers_proxy", "/opt/project/lers/conf/lers_proxy.conf"] 
        elif self.role == 2: # CDN
            self.lers_file_list = ["/usr/local/sbin/lers","/usr/local/etc/lers.cdn.lua","/usr/local/sbin/lers_proxy","/usr/local/etc/lers_proxy.cdn.conf"]
            
        for file in self.lers_file_list:
            if not os.path.exists(file):
                self.installed = False; 
                self.code = -1
                return -1
        self.version = commands.getstatusoutput("%s --version | grep Version" %self.lers_file_list[0] )[1].split()[2] 
        return 0

    def checkproc(self):
        """检测当前LERS进程是否正常"""
        cmd = "/sbin/pidof lers"
        ret = commands.getstatusoutput(cmd)        
        if ret[0] != 0:
            self.code = 1 
        return ret[0]
            
    #@conn_try_again
    def checkccapi(self,timeout=CCAPI_TIMEOUT,retry=CCAPI_RETRY):
        """检测直播控制中心接口"""
        #cmd = "curl --retry %s --connect-timeout %s -so /dev/null http://api.live.letv.com/noc.gif" %(retry, timeout)
        #trace_log("ccapi: %s" %cmd)
        #ret = commands.getstatusoutput(cmd)
        req = urllib2.Request(CCAPI)
        try:
            res = urllib2.urlopen(req, timeout=timeout)
            trace_log("Get ccapi url: %s."%CCAPI)
        except urllib2.HTTPError, e:
            error_log("HTTPError code: %s."%e.code)
            error_log("HTTPError reason: %s."%e.reason)
            self.code = 2
            return 1
        except urllib2.URLError, e:
            error_log("URLError reason: %s."%e.reason)
            #print e.read()
            self.code = 2
            return 1
        else:
            trace_log("Return code: %s."%res.getcode())
            return 0

    def checkpid(self, pidfile=LERS_PID_FILE, timeout=PIDMODTIME_THRESHOLD):
        """检测pid是否正常更新"""
        mtime = time.time() - os.stat(pidfile).st_mtime 
        if mtime > timeout :   #修改时间间隔大于3分钟
            self.code = 3 
            return -1 
        return 0

    def getconffilenum(self, conf=LERS_CDN_CONF):
        """获取配置文件配置的进程数"""
        cmd = "grep workprocess %s | awk -F '[,=]' '{print $2}'" %conf
        filenum = commands.getstatusoutput(cmd)[1].strip()
        return int(filenum)

    def getruntime(self, pid):
        """获取单个LERS进程运行时间"""
        user_hz = commands.getstatusoutput("getconf CLK_TCK")[1]
        jiffies = commands.getstatusoutput("cat /proc/%s/stat | cut -d\" \" -f22" %pid)[1]
        sys_uptime = commands.getstatusoutput("cat /proc/uptime | cut -d\" \" -f1")[1]
        runtime = int(float(sys_uptime)) - int(jiffies)/int(user_hz)
        return runtime

    #def checkrestartcount(self,pid,port='1935'):
    def checkrestartcount(self, pid, program='lers', port='1935', infofile=LERS_START_INFO_FILE, threshold=RESTART_THRESHOLD):
        """检测重启阈值,目前program参数未用"""
        start_info_file = infofile+'.'+port;
        #trace_log("Start checking: %s." %start_info_file)
        runtime = self.getruntime(pid)
        startinfo = {'pid':pid, 'runtime':runtime }
        #trace_log("Getted startinfo: %s." %startinfo)
        fileinfo = {} 
        if os.path.exists(start_info_file):
            tmp = commands.getstatusoutput("cat %s" %start_info_file)[1]
            if len(tmp) != 0:
                fileinfo = json.loads(json.dumps(eval(tmp)))
                #trace_log("Getted fileinfo: %s." %fileinfo)
        if not os.path.exists(start_info_file) or len(fileinfo) == 0: #第一次运行或者start_info_file没有内容，需要建立文件并写入当前信息
            trace_log("Check file: %s, file is not exists.setup and write.info: %s." %(start_info_file,startinfo))
            with open(start_info_file, 'w') as f:
                f.write(str(startinfo))
            return 0
        else: #文件存在且有信息，需要对比信息
            if startinfo['pid'] == fileinfo['pid']:  #pid相同，更新runtime
                trace_log("Check file: %s, pid is same,update runtime.%s --> %s." %(start_info_file,fileinfo,startinfo))
                with open(start_info_file, 'w') as f:
                    f.write(str(startinfo))
                return 0
            elif fileinfo['runtime'] > threshold: #pid不同，runtime大于阈值也要更新       
                trace_log("Check file: %s, runtime is %s, more than threshold: %s.update runtime.%s --> %s"%(start_info_file,fileinfo['runtime'],threshold,fileinfo,startinfo))
                with open(start_info_file, 'w') as f:
                    f.write(str(startinfo))
                return 0
            elif fileinfo['runtime'] < threshold: #pid不同，runtime小于阈值也要更新
                error_log("Check file: %s, runtime is %s,less than threshold: %s.update runtime.%s --> %s"%(start_info_file,fileinfo['runtime'],threshold,fileinfo,startinfo))
                with open(start_info_file, 'w') as f:
                    f.write(str(startinfo))
                self.code = 4
                return -1

    def getcputil(self, pidstr, program='lers', topnum=3): # pidstr, pid string like this: "1223,1234,12466,12456"
        """获取program 最大cpu利用率"""
        #cmd = "top -b -d 1 -n %s -H -p$(for pid in `pgrep %s`; do echo -n $pid,;  done | sed 's/.$//g') | grep %s | awk 'BEGIN{cpu=0;} {if($9>cpu){cpu=$9;}}  END{print cpu;}'" %(topnum,program,program)
        cmd = "top -b -d 1 -n %s -H -p%s | grep lers | awk 'BEGIN{cpu=0;} {if($9>cpu){cpu=$9;}}  END{print cpu;}'" %(topnum, pidstr)
        cpuper = commands.getoutput(cmd)
        trace_log("Get the highest cpu utility %s%% of program %s." %(cpuper,program))
        return "%.2f" %float(cpuper)

    def getmemutil(self, pid, program='lers'):
        memutil = int(commands.getoutput("cat /proc/%s/statm" %pid).split()[1])*4096/1024/1024 #单位MB
        trace_log("Get the memutil of %s: %sMB." %(program,memutil))
        return memutil 

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
 
    #开始检查LERS
    try:
        lers = CheckLERS() 
        #检测是否安装LERS :auto code
        lers.checkinstall()
        if lers.installed:
            trace_log("LERS is already installed.")
        else:
            error_log("LERS is not installed. exit..")
            code2file(lers.code)
            sys.exit()

        #检测进程是否在运行 :auto code
        ret = lers.checkproc() 
        if ret == 0:
            trace_log("LERS progress is running.")
        else:
            error_log("LERS progress is not running, exit...")
            code2file(lers.code)
            sys.exit(1)

        #检测直播控制中心API接口是否正常 :auto code 
        ret = lers.checkccapi()
        if ret == 0:
            trace_log("Get ccapi success.")
        else:
            error_log("Get ccapi failed, exit...")
            code2file(lers.code)
            sys.exit(1)

        #版本低于1.1-2833的暂不检测        
        if lers.version.split('-')[0] == '1.1' and int(lers.version.split('-')[1]) < 2833:
            trace_log("LERS version is lower than 1.1-2833,exit...") 
            code2file(0)
            sys.exit(0)

        # 进程检测
        trace_log("LERS in running in new process mode.")
        #检测进程数量和配置文件是否相符
        if lers.role == 1: #LIVE
            if len(lers.rtmppids) == lers.getconffilenum(conf=LERS_LIVE_CONF):
                trace_log("There are %s process is runnning: %s." %(len(lers.rtmppids),lers.rtmppids))
            else:
                error_log("Running process number is not the same as %s."%LERS_LIVE_CONF)
                error_log("There are %s process is runnning: %s,but the number of %s is %s." %(len(lers.rtmppids),lers.rtmppids,LERS_LIVE_CONF,filenum))
                lers.code = 5
                code2file(lers.code)
                sys.exit(1)
        elif lers.role == 2:  #CDN
            filenum = lers.getconffilenum(conf=LERS_CDN_CONF)
            if len(lers.rtmppids) == filenum:
                trace_log("There are %s process is runnning: %s." %(len(lers.rtmppids),lers.rtmppids))
            else:
                error_log("Running process number is not the same as %s."%LERS_CDN_CONF)
                error_log("There are %s process is runnning: %s,but the number of %s is %s." %(len(lers.rtmppids),lers.rtmppids,LERS_CDN_CONF,filenum))
                lers.code = 5
                code2file(lers.code)
                sys.exit(1)

        #检测进程是否有卡死，正常情况下pid文件1分钟更新一次 :auto code 
        for oneport in lers.rtmpports:
            pidfile = "/var/run/lers.%s.pid" %oneport;
            ret = lers.checkpid(pidfile)
            if ret == 0:
                trace_log("The pid file %s is updating." %pidfile)
            else:
                error_log("The pid file %s hasn't updated for 3 minutes,exit..." %pidfile)
                code2file(lers.code)
                sys.exit(1)

        #检测LERS进程在30分钟内是否有重启 :auto code
        for oneport in lers.rtmpports:
            pidfile = "/var/run/lers.%s.pid" %oneport;
            pid = commands.getoutput("cat %s" %pidfile)
            ret = lers.checkrestartcount(pid,port=oneport)
            if ret != 0:
                error_log("Restart 2 times in %s seconds." %RESTART_THRESHOLD)
                code2file(lers.code)
                sys.exit(1)

        #检测R2H进程在30分钟内是否有重启 :auto code
        if lers.role == 2: # CDN r2h进程
            for oneport in lers.r2hports:
                pidfile = "/var/run/r2h.%s.pid" %oneport;
                pid = commands.getoutput("cat %s" %pidfile)
                ret = lers.checkrestartcount(pid,port=oneport)
                if ret != 0:
                    error_log("Restart 2 times in %s seconds." %RESTART_THRESHOLD)
                    code2file(lers.code)
                    sys.exit(1)
         
        #检测LERS进程利用率是否达到100%
        rtmppidstr = ','.join(lers.rtmppids) 
        cpuper = lers.getcputil(pidstr=rtmppidstr, program='lers_rtmp')
        if float(cpuper) > 99:
            code2file(6)
            sys.exit(1)

        if lers.role == 2: # CDN r2h进程
            r2hpidstr = ','.join(lers.r2hpids) 
            cpuper = lers.getcputil(pidstr=rtmppidstr, program='lers_r2h')
            if float(cpuper) > 99:
                code2file(6)
                sys.exit(1)

        #监测LERS进程内存使用是否超过5G
        for oneport in lers.rtmpports:
            pidfile = "/var/run/lers.%s.pid" %oneport;
            pid = commands.getoutput("cat %s" %pidfile)
            memutil = lers.getmemutil(pid, "lers.%s" %oneport)
            if memutil > 5000:
                code2file(7)
                sys.exit(1)

        if lers.role == 2: # CDN r2h进程
            for oneport in lers.r2hports:
                pidfile = "/var/run/r2h.%s.pid" %oneport;
                pid = commands.getoutput("cat %s" %pidfile)
                memutil = lers.getmemutil(pid, "lers.%s" %oneport)
                if memutil > 5000:
                    code2file(7)
                    sys.exit(1)

        #正常
        code2file(lers.code)
    except SystemExit:
        pass

    except BaseException,e:
        error_log(e)
        code = -3
        code2file(code) 

    finally:
        os.remove(PID_PATH)
