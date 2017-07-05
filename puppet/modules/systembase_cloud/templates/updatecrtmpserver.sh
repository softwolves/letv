#!/bin/bash
#Power by duhaibin@letv.com
#2014-09-11 16:10:05
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
lockfile='/var/run/update_crtmpserver.pid'
# single instance
if test -f $lockfile;then
    oldpid=`cat $lockfile|head -1`
    if [ `ps -p $oldpid -o comm= | wc -l` -eq 1 ];then
        echo "Error: already running. [${oldpid}]"
        exit 0
    fi
else
    echo $$ > $lockfile
fi
trap "rm -fv $lockfile;exit 0;" 0 3 15



crtmpserver_md5="`cat /usr/local/etc/md5-crtmpserver`"

if [ ! -f /usr/local/sbin/crtmpserver ]
then
	touch /usr/local/sbin/crtmpserver
fi

#download_addr1="220.181.155.10"
#download_addr2="123.125.89.16"
#download_addr3="115.182.94.72/cdn/live/"
#download_addr3="115.182.63.202"
pidfile=/var/run/crtmpserver.pid
download_addr="leju.down.letv.com"
download_bak="115.182.94.72"
real_crtmpserver_md5="`md5sum /usr/local/sbin/crtmpserver | awk '{print $1}'`"
filename="crtmpserver_${crtmpserver_md5}"


if [ "$crtmpserver_md5" != "$real_crtmpserver_md5" ]
then
	rm -rf /usr/local/sbin/crtmpserver_tmp
        wget -t 2 -T 30 -c -N -q -O /usr/local/sbin/crtmpserver_tmp http://$download_addr/update/${filename}

        crtmpserver_tmp_md5="`md5sum /usr/local/sbin/crtmpserver_tmp | awk '{print $1}'`"
                if [ "$crtmpserver_md5" = "$crtmpserver_tmp_md5" ]
		then

                        rm -rf /usr/local/sbin/crtmpserver
                        mv /usr/local/sbin/crtmpserver_tmp /usr/local/sbin/crtmpserver

        		killall -9 crtmpserver
        		sleep 1 
        		killall -9 crtmpserver
        		sleep 1
		        chown www.root $pidfile
			chmod 755 /usr/local/sbin/crtmpserver
        		/usr/local/sbin/crtmpserver --pid=/var/run/crtmpserver.pid /usr/local/etc/crtmpserver.lua
		else
			rm -rf /usr/local/sbin/crtmpserver_tmp_sec
                        wget -t 2 -T 30 -c -N -q -O /usr/local/sbin/crtmpserver_tmp_sec  http://${download_bak}/update/${filename}
                        killall -9 crtmpserver
                        sleep 1
                        killall -9 crtmpserver
                        sleep 1                        
                        rm -rf /usr/local/sbin/crtmpserver
                        mv /usr/local/sbin/crtmpserver_tmp_sec /usr/local/sbin/crtmpserver
                        chmod 755 /usr/local/sbin/crtmpserver
		        chown www.root $pidfile
                        /usr/local/sbin/crtmpserver --pid=/var/run/crtmpserver.pid /usr/local/etc/crtmpserver.lua
		fi
fi
md5sum /usr/local/sbin/crtmpserver |awk '{print $1}' >/usr/local/etc/md5-crtmpserver
