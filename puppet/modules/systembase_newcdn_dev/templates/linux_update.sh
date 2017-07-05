#!/bin/bash

PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
#download_addr="115.182.94.72"
#ntpdate 132.163.4.102
#ntpdate 0.centos.pool.ntp.org
#ntpdate 1.centos.pool.ntp.org
#ntpdate 2.centos.pool.ntp.org


md5sum /lib/libc.so.6 2>&1|awk '{print $1}' >/usr/local/zabbix/md5-libc
md5sum /usr/local/sbin/watchdog 2>&1|awk '{print $1}' > /home/update/puppetmd5file/md5-watchdog
md5sum /usr/local/sbin/cagent 2>&1|awk '{print $1}' > /home/update/puppetmd5file/md5-cagent
md5sum /usr/local/sbin/xagent 2>&1|awk '{print $1}' > /home/update/puppetmd5file/md5-xagent
#md5sum /home/update/file/letv_trafficserver.tar.gz 2>&1|awk '{print $1}' > /home/update/puppetmd5file/md5-ats
#md5sum /usr/local/sbin/nginx 2>&1|awk '{print $1}' > /home/update/puppetmd5file/md5-nginx
md5sum /usr/local/nginx/sbin/nginx 2>&1|awk '{print $1}' > /home/update/puppetmd5file/md5-nginx
md5sum /usr/local/sbin/crtmpserver 2>&1|awk '{print $1}' > /home/update/puppetmd5file/md5-crtmpserver
md5sum /usr/lib64/libsnapimg.so 2>&1|awk '{print $1}' > /home/update/puppetmd5file/md5-libsnapimg
md5sum /usr/local/bin/watchdog2 2>&1|awk '{print $1}' > /home/update/puppetmd5file/md5-watchdog2
md5sum /cto2/ctod 2>&1|awk '{print $1}' > /home/update/puppetmd5file/md5-ctod
md5sum /cto2/lib/libstdc++.so.6 2>&1|awk '{print $1}' > /home/update/puppetmd5file/md5-libstdc
md5sum /opt/project/slice2http/bin/slice2http 2>&1|awk '{print $1}' > /home/update/puppetmd5file/md5-slice2http
md5sum /home/update/file/letv_trafficserver.tar.gz 2>&1|awk '{print $1}' > /home/update/puppetmd5file/md5-ats
md5sum /usr/local/sbin/pinger 2>&1|awk '{print $1}' > /home/update/puppetmd5file/md5-pinger

if [ ! -f /usr/local/consul/sbin/consul ];then
	rm -rf /home/update/file/spider.tar.gz
	md5sum /home/update/file/spider.tar.gz 2>&1|awk '{print $1}' > /home/update/puppetmd5file/md5-spider
else
	md5sum /home/update/file/spider.tar.gz 2>&1|awk '{print $1}' > /home/update/puppetmd5file/md5-spider
fi

/usr/bin/monit monitor all

