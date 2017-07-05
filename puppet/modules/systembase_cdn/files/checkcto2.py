#!/usr/bin/env python
#coding: utf-8
# (c) 2015 , Shichao Gao <gaoshichao@letv.com>
#
# 该脚本用于检查cto2状态
#
# 版本: v1.0.20160125
#
# v1.1.20160128
#   修改获取iptables信息时间为10s
# v1.1.20160127
#   NEWCDN LIVE Front设备无测速文件下载配置,排除检测
#   修改获取ip方式，获取第一个非127.0.0.1的ip
# v1.0.20160125 
#   监控cto2安装
#   监控iptables端口配置 
#   本机50080端口测试文件下载监控
##############################################################################
import os,sys
import time
import subprocess
import signal
import commands
import socket,re

# [LOG]
LOG_FILE = "/dev/shm/.checkcto2.log"
FILENAME = __file__.split('.')[0].split('/')[-1]
PID = os.getpid()
PID_PATH = "/tmp/"+FILENAME+".pid"
FORMAT_TIME = "%Y-%m-%d %H:%M:%S"
FORMAT_LOG = "[%(local_time)s][%(level)s][%(pid)s] %(log)s \n"

# [CTO]
CTO2_FILE_LIST = ["/cto2/ctocmd","/cto2/ctod"]
CODE_FILE = "/usr/local/zabbix/tmp/cto2.status"
CTO2PORTS = ['50080', '50110', '50443', '51935', '58080']
PORT_BAND = 50080    # 测速下载端口
TIMEOUT_BAND = 10    # 下载测速文件超时时间(s)         
RETRY_BAND = 3       # 下载一个测速文件重试次数              
TIMEOUT_SHELL = 10    # shell运行超时时间(s)

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

class CheckCTO2():
    """CTO2 检测类"""
    def __init__(self):
        self.cto2_file_list = CTO2_FILE_LIST;     # CTO2 文件列表（为确认CTO2是否安装）
        self.code = 0                           # CTO2状态，默认为0（正常）
        """
        Status    Information
         -3         状态未知
         -2         检查脚本正在运行
         -1         没有CTO2相关文件
          0         CTO2服务正常
          1         iptables异常
          2         下载本机文件异常
        """
        self.cto2_installed = True;             # CTO2是否安装，默认是True（已安装）
    
    def checkinstall(self):
        """检测CTO2是否安装"""
        for file in self.cto2_file_list:
            if not os.path.exists(file):
                self.cto2_installed = False;

    def getports(self):
        """获取所有port信息,返回list ports"""
        cmd = "/etc/init.d/iptables status | grep 'tcp dpt' | awk -F '[ :]+' '{print $9}'"
        ret, stdout, stderr, poll = shell_run(cmd)
        lports = stdout.strip().split('\n')
        return lports


    def restartcto2(self):
        """重启CTO2"""
        cmd = "/etc/init.d/cto2.3 restart"
        #ret, stdout, stderr = shell_run(cmd)
        #ret = commands.getstatusoutput(cmd)[0]
        ret = os.system(cmd)  #并卵用
        return ret

def gethostip():
    """获取本机IP地址"""
    #cmd = "cat /usr/local/etc/hosts.conf  | grep smokeip | awk -F ':' '{print $2}'"
    cmd = "/sbin/ifconfig | grep 'inet addr' | grep -v 127.0.0.1 | head -n 1 | awk -F '[ :]+' '{print $4}'"
    hostip = commands.getoutput(cmd)
    return hostip 

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
        #cmd = "curl --connect-timeout %s -so /dev/null http://%s:%d/letvabcdeasktf1k" % (timeout, ip, port) 
        cmd = "curl --connect-timeout %s -so /dev/null http://%s:%d/letvabcdeasktf1k -x %s:%s -w %%{http_code}" % (timeout, ip, port, ip, port) 
        ret, stdout, stderr, poll = shell_run(cmd)
        if poll == 0 and stdout == '200':
            trace_log("Download %s:%s successfully, return %s." %(ip, port, stdout))
            return 0
        else:
            return 1
    #sys.exit(1) 

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


    #开始检查CTO2
    try:
        #如果是NEWCDN跳过
        hostname = socket.gethostname()
        if re.match("NEWCDN", hostname) or re.match("LIVE", hostname) or re.match("Front", hostname):
            trace_log("This dev is NEWCDN or LIVE or Front.pass")
            code2file(0)
            sys.exit()

        cto2 = CheckCTO2() 
        cto2.checkinstall()
        if cto2.cto2_installed == True:
            trace_log("CTO2 has already installed.")
        else:
            error_log("CTO2 is not installed. exit..")
            code2file(-1)
            sys.exit()
        
        #检测端口是否均正常
        ports = cto2.getports()
        for port in CTO2PORTS:
            if port in ports:
                trace_log("Port %s found in iptables." %port)
            else:
                trace_log("Can't find port %s in iptables." %port)
                code2file(1) 
                sys.exit()

        #下载本机cto2端口
        hostip = gethostip()
        ret = checkdownload(hostip)
        if ret == 0:
            trace_log("Download %s 1M success." %hostip)
        else:
            error_log("Download %s 1M failed!" %hostip)
            code2file(2)
            sys.exit()

        if cto2.code == 0:
            trace_log("CTO2 is normal!")
        code2file(cto2.code)

    except SystemExit:
        pass

    except BaseException,e:
        error_log(e)
        code = -3
        code2file(code) 

    finally:
        os.remove(PID_PATH)
