#!/bin/bash
#Power by xwt
#Last edit date 2012-9-12
PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/games:/usr/local/sbin:/usr/local/bin:/root/bin
pidfile=/var/run/crtmpserver.pid

nc -z -r 127.0.0.1 1935 >/dev/null
if [ $? -ne 0 ]
then
	if [ -f /usr/local/sbin/crtmpserver ];then
   		tag1=`ls -l /usr/local/sbin/crtmpserver | awk '{print $1}'`
   		if [ ${tag1} != "-rwxr-xr-x" ];then
       			chmod 755 /usr/local/sbin/crtmpserver
   		fi
	fi

	cd /home/update/core/

        killall -9 crtmpserver rtmp2http
        sleep 2
        killall -9 crtmpserver rtmp2http
        sleep 2
	/usr/local/sbin/crtmpserver --pid=/var/run/crtmpserver.pid /usr/local/etc/crtmpserver.cdn.lua
fi

md5sum /usr/local/sbin/crtmpserver |awk '{print $1}' >/usr/local/etc/md5-crtmpserver
md5sum /lib/libudtp.so.0 2>&1|awk '{print $1}' >/usr/local/etc/md5-libudtp
