#!/bin/bash

#Power by xwt
#Last edit date 2012-10-10

PATH=/usr/kerberos/sbin:/usr/kerberos/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin

curl --max-time 30 --retry 3  http://127.0.0.1:10123/version 

if [ $? -ne 0 ]
then 
	sleep 5
        curl --max-time 30 --retry 3  http://127.0.0.1:10123/version
        if [ $? -ne 0 ]
        then
		sleep 5
                curl --max-time 30 --retry 3  http://127.0.0.1:10123/version
                if [ $? -ne 0 ]
                then
			killall -9 watchdog
			killall -9 find 
                        sleep 2
			killall -9 find 
			killall -9 watchdog
			
                        #rm -rf /tmp/core.*
                        #rm -rf /tmp/watchdog.core
                        rm -rf /var/run/watchdog.pid
			ulimit -s 262140
			ulimit -n 600000
			ulimit -c unlimited
                        cd /tmp
                        /usr/local/sbin/watchdog 
#			curl -o /dev/null -m 10 "http://115.182.94.72/data_import/import_crontab.php?ts_url=restart_centos6_watchdog"
                fi
        fi
fi

md5sum /usr/local/sbin/watchdog 2>&1|awk '{print $1}' >/letv/soft/watchdog/md5-watchdog
