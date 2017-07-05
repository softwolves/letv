#!/bin/bash
#Power by duhaibin@letv.com
#2014-08-07 12:33:05
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
lockfile='/var/run/update_watchdog.pid'
# single instance
if test -f $lockfile;then
    oldpid=`cat $lockfile|head -1`
    if [ `ps -p $oldpid -o comm= | wc -l` -eq 1 ];then
        echo "Error: already running. [${oldpid}]"
        exit 1
    fi
else
    echo $$ > $lockfile
fi
trap "rm -fv $lockfile;exit 1;" 0 3 15


stop_watchdog() {
        killall -9 watchdog
        sleep 2
        killall -9 watchdog
        sleep 1
        killall -9 watchdog
}

start_watchdog() {
        chmod 755 /usr/local/sbin/watchdog
        ulimit -c unlimited
        /usr/local/sbin/watchdog
}

watchdog_md5="`cat /letv/soft/watchdog/md5-watchdog `"
if [ ! -f /usr/local/sbin/watchdog ]
then
        touch /usr/local/sbin/watchdog
fi

download_addr="leju.down.letv.com"
download_bak="115.182.94.72"
real_watchdog_md5="`md5sum /usr/local/sbin/watchdog | awk '{print $1}'`"
filename="watchdog_${watchdog_md5}"
if [ "$watchdog_md5" != "$real_watchdog_md5" ]
then
        rm -rf /usr/local/sbin/watchdog_tmp
 	wget -t 2 -T 30 -c -N -q -O /usr/local/sbin/watchdog_tmp http://$download_addr/update/${filename}
        watchdog_tmp_md5="`md5sum /usr/local/sbin/watchdog_tmp | awk '{print $1}'`"
		if [ "$watchdog_md5" = "$watchdog_tmp_md5" ]
		then
                	stop_watchdog
			rm -rf /usr/local/sbin/watchdog
                	mv /usr/local/sbin/watchdog_tmp /usr/local/sbin/watchdog
                	start_watchdog
		else
        		wget -t 2 -T 30 -c -N -q -O /usr/local/sbin/watchdog_tmp_sec  http://${download_bak}/update/${filename}
                        stop_watchdog
                        rm -rf /usr/local/sbin/watchdog
                        mv /usr/local/sbin/watchdog_tmp /usr/local/sbin/watchdog
                        start_watchdog
		fi
fi			

md5sum /usr/local/sbin/watchdog 2>&1|awk '{print $1}' >/letv/soft/watchdog/md5-watchdog
