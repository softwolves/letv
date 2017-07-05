#!/bin/bash

PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin


crtmpserver_md5="`cat /usr/local/etc/md5-crtmpserver`"

if [ ! -f /usr/local/sbin/crtmpserver ]
then
	touch /usr/local/sbin/crtmpserver
fi

download_addr1="220.181.155.10"
download_addr2="123.125.89.16"
download_addr3="115.182.94.72/cdn/live/"
#download_addr3="115.182.63.202"

hostname  |grep -iq cnc
if [ $? -eq 0 ]
then
	download_addr=$download_addr2
else
	hostname  |grep -iq ctc
	if [ $? -eq 0 ]
	then
		download_addr=$download_addr1
	else
		download_addr=$download_addr3
	fi

fi


real_crtmpserver_md5="`md5sum /usr/local/sbin/crtmpserver | awk '{print $1}'`"

if [ "$crtmpserver_md5" != "$real_crtmpserver_md5" ]
then
	rm -rf /usr/local/sbin/crtmpserver
	axel -a -o /usr/local/sbin/crtmpserver http://$download_addr/crtmpserver
	chmod 755 /usr/local/sbin/crtmpserver

        killall -9 crtmpserver
        sleep 2
        killall -9 crtmpserver
        sleep 2
        sudo -u www /usr/local/sbin/crtmpserver /usr/local/etc/crtmpserver.lua
fi

md5sum /usr/local/sbin/crtmpserver |awk '{print $1}' >/usr/local/etc/md5-crtmpserver
