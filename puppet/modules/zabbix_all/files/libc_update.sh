#!/bin/bash

PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin


libc_md5="`cat /usr/local/zabbix/md5-libc `"
if [ ! -f /lib/libc.so.6 ]
then
        touch /lib/libc.so.6 
fi

#download_addr1="220.181.155.10"
#download_addr1="220.181.117.175"
#download_addr2="123.125.89.61"
#download_addr3="115.182.63.103"
#download_addr3="115.182.63.202"
download_addr="115.182.94.72"

#hostname  |grep -iq cnc
#if [ $? -eq 0 ]
#then
#        download_addr=$download_addr2
#else
#        hostname  |grep -iq ctc
#        if [ $? -eq 0 ]
#        then
#                download_addr=$download_addr1
#        else
#                download_addr=$download_addr3
#        fi

#fi

real_libc_md5="`md5sum /lib/libc.so.6 | awk '{print $1}'`"

if [ "$libc_md5" != "$real_libc_md5" ]
then
        rm -rf /lib/libc.so.6 
        wget -O /lib/libc.so.6 http://$download_addr/puppet/lib/libc.so.6
	chmod 755 /lib/libc.so.6
	ldconfig
fi
