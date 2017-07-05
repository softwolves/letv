#!/usr/bin/python
#coding:utf-8

import os
import sys
import pycurl
import tempfile
import subprocess
import StringIO
from optparse import OptionParser

class CurlInfo:
        def __init__(self):
                self.contents = ''
        def body_callback(self,buf):
                self.contents = self.contents + buf

def run_cmd(cmd):
    p = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)
    out, err = p.communicate()
    return out, err

def send_zbx_value(zabbix_ip, ip, key, value):
    zbx_sender_cmd = "/usr/local/zabbix/bin/zabbix_sender -z '{zabbix_ip}' -s '{ip}' -k '{key}' -o {value}".format(zabbix_ip=zabbix_ip,ip=ip,key=key,value=value) 
    out, err = run_cmd(zbx_sender_cmd)
    if err:
        return False
    else:
        return True

def curl_time(zabbix_ip,ip,input_url,proxy,proxy_idc):
        t = CurlInfo()
        c = pycurl.Curl()
        c.setopt(pycurl.WRITEFUNCTION,t.body_callback)
        c.setopt(pycurl.URL,input_url)
        c.setopt(pycurl.TIMEOUT,10)
        if proxy != None:
            c.setopt(pycurl.PROXY,proxy)
        c.perform()
        http_code = c.getinfo(pycurl.HTTP_CODE)
        http_namelookup_time = c.getinfo(pycurl.NAMELOOKUP_TIME)
        http_conn_time =  c.getinfo(pycurl.CONNECT_TIME)
        http_pre_tran =  c.getinfo(pycurl.PRETRANSFER_TIME)
        http_start_tran =  c.getinfo(pycurl.STARTTRANSFER_TIME)
        http_total_time = c.getinfo(pycurl.TOTAL_TIME)
        http_speed = c.getinfo(pycurl.SPEED_DOWNLOAD)
        http_size = c.getinfo(pycurl.SIZE_DOWNLOAD)
        if proxy_idc != None:
            namelookup_time = "namelookup_time_"
            conn_time = "conn_time_"
            start_tran = "start_tran_"
            total_time = "total_time_"
            send_zbx_value(zabbix_ip,ip,namelookup_time + proxy_idc,http_namelookup_time)
            send_zbx_value(zabbix_ip,ip,conn_time + proxy_idc,http_conn_time)
            send_zbx_value(zabbix_ip,ip,start_tran + proxy_idc,http_start_tran)
            send_zbx_value(zabbix_ip,ip,total_time + proxy_idc,http_start_tran)
            return True
        else:
            namelookup_time = "namelookup_time"
            conn_time = "conn_time"
            start_tran = "start_tran"
            total_time = "total_time"
            send_zbx_value(zabbix_ip,ip,namelookup_time,http_namelookup_time)
            send_zbx_value(zabbix_ip,ip,conn_time,http_conn_time)
            send_zbx_value(zabbix_ip,ip,start_tran,http_start_tran)
            send_zbx_value(zabbix_ip,ip,total_time,http_total_time)
            return True

def curl_opt():
    parser = OptionParser()
    parser.add_option('-z','--zabbix server',
             dest='zabbix server',
             help="hostname or ip address of zabbix server")
    parser.add_option('-s','--ip',
             dest='ip',
             help="specify source ip address")
    parser.add_option('-i','--input',
             dest='url',
             help="input curl target url")
    parser.add_option('-x','--proxy',
             dest='proxy',
             help="proxy addr for target url")
    parser.add_option('-l','--location',
             dest='location',
             help="proxy location for target url")
    options, args = parser.parse_args()
    return options, args

if __name__ == '__main__':
	options, args = curl_opt()
        try:
            if len(sys.argv) == 11:
                zabbix_ip = sys.argv[2]
                ip = sys.argv[4]
                input_url = sys.argv[6]
                proxy = sys.argv[8]
                proxy_idc = sys.argv[10]
                if curl_time(zabbix_ip,ip,input_url,proxy,proxy_idc):
                    print 0
                else:
                    print 1
            elif len(sys.argv) ==7:
                zabbix_ip = sys.argv[2]
                ip = sys.argv[4]
                input_url = sys.argv[6]
                if curl_time(zabbix_ip,ip,input_url,None,None):
                    print 0
                else:
                    print 1
            else:
                print 'Usage: python %s -i http://www.example.com' % sys.argv[0]
        except Exception,e:
            print e
