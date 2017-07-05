#!/bin/bash
PATH=/usr/local/jdk1.6.0_33/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin

while  ps aux |grep 'smokeping.dist' |grep -qv grep  
do
        if [ -f /tmp/data.cache ] 
        then
                rm -rf /tmp/data.cache
        fi
        if [ -f /data/smokeping/data.cache ]
        then
                rm -rf /data/smokeping/data.cache
        fi	
	ps aux |grep 'smokeping.dist' |grep -v grep |awk '{if (NR==1) print $2}'  |xargs kill -9 
	sleep 0.5
done

