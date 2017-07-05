#!/bin/bash
#Power by xwt
#Last edit date 2016-3-9
PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/games:/usr/local/sbin:/usr/local/bin:/root/bin
pidfile=/var/run/lers.pid

if [ -f /usr/local/sbin/lers ];then
	tag1=`ls -l /usr/local/sbin/lers | awk '{print $1}'`
	if [ ${tag1} != "-rwxr-xr-x" ];then
		chmod 755 /usr/local/sbin/lers
	fi
fi
if [ -f /usr/local/sbin/lers_proxy ];then
        tag1=`ls -l /usr/local/sbin/lers_proxy | awk '{print $1}'`
        if [ ${tag1} != "-rwxr-xr-x" ];then
                chmod 755 /usr/local/sbin/lers_proxy
        fi
fi

nc -z -r 127.0.0.1 1935 &>/dev/null
if [ $? -ne 0 ]
then
	cd /home/update/core/
	lerspid=`ps -ef |grep lers.cdn.lua | grep -v grep | awk '{print $2}'`
	if [ ! -z $lerspid ];then
		echo $lerspid
		kill -9 $lerspid
		sleep 2
	fi
	/usr/local/sbin/lers -c /usr/local/etc/lers.cdn.lua

fi


md5sum /usr/local/sbin/lers |awk '{print $1}' >/usr/local/etc/md5-lers
md5sum /usr/local/sbin/lers_proxy |awk '{print $1}' >/usr/local/etc/md5-lers_proxy
md5sum /lib/libudtp.so.0 2>&1|awk '{print $1}' >/usr/local/etc/md5-libudtp
