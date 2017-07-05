#!/bin/bash

PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
download_addr="115.182.94.72"
ntpdate 132.163.4.102
ntpdate 0.centos.pool.ntp.org
ntpdate 1.centos.pool.ntp.org
ntpdate 2.centos.pool.ntp.org

if [ ! -d /livemem/live/live_temp ]
then

mkdir -p /livemem/live/live_temp
chmod -R 755 /livemem/live/live_temp
chown -R www:www /livemem/live/live_temp

fi

md5sum /lib/libc.so.6 2>&1|awk '{print $1}' >/usr/local/zabbix/md5-libc
