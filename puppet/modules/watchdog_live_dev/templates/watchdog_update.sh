#!/bin/bash
#Power by duhaibin@letv.com
#2015-07-17 16:32:28
#通过ansible升级watchdog二进制文件
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
lockfile="/var/run/ansible_update_watchdog.pid"

#single instance
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

if [ ! -f /usr/local/sbin/watchdog ]
then
        touch /usr/local/sbin/watchdog
fi

if [ ! -d /home/update/puppetmd5file ]
then
        mkdir -p /home/update/puppetmd5file
        mkdir -p /home/update/md5file
        mkdir -p /home/update/file
	mkdir -p /home/update/shell
fi


download_cloud="test.coop.gslb.letv.com"
download_all="115.182.94.72"
update_watchdog_md5="`cat /home/update/puppetmd5file/md5-watchdog`"
run_watchdog_md5="`md5sum /usr/local/sbin/watchdog | awk '{print $1}'`"
filename_update="watchdog_${update_watchdog_md5}"
filename_run="watchdog_${run_watchdog_md5}"

if [ "$filename_update" != "$filename_run" ]
then
#########判断备份目录是否有当前运行的watchdog，如果没有就备份一下
    if [ ! -f /home/update/file/${filename_run} ];then
        cp -f /usr/local/sbin/watchdog /home/update/file/${filename_run}
        ls -lt /home/update/file/watchdog_*| awk '{print $NF}' |sed -n '8,$p'| xargs -i rm -rf {}
    fi    

#########检查备份目录是否有要更新的文件
    if [ -f /home/update/file/${filename_update} ];then
        watchdog_bak_md5="`md5sum /home/update/file/${filename_update} | awk '{print $1}'`"
        chmod 755 /home/update/file/${filename_update}
        if [ "$update_watchdog_md5" = "$watchdog_bak_md5" ];then
		stop_watchdog
		rm -rf /usr/local/sbin/watchdog
                cp -f /home/update/file/${filename_update} /usr/local/sbin/watchdog
		start_watchdog
        else
            mv -f /home/update/file/${filename_update} /home/update/file/watchdog_${watchdog_bak_md5} 
        fi
    else
        rm -rf /usr/local/sbin/watchdog_tmp
        wget -t 2 -T 30 -c -N -q -O /usr/local/sbin/watchdog_tmp http://$download_cloud/update/${filename_update}
        watchdog_tmp_md5="`md5sum /usr/local/sbin/watchdog_tmp | awk '{print $1}'`"
        chmod 755 /usr/local/sbin/watchdog_tmp
        if [ "$update_watchdog_md5" = "$watchdog_tmp_md5" ]
        then
                if [ -s /usr/local/sbin/watchdog_tmp ];then
                    stop_watchdog
                    rm -rf /usr/local/sbin/watchdog
                    mv /usr/local/sbin/watchdog_tmp /usr/local/sbin/watchdog
                    start_watchdog
                fi
        else
            wget -t 2 -T 30 -c -N -q -O /usr/local/sbin/watchdog_tmp_sec http://$download_all/update/${filename_update}
            chmod 755 /usr/local/sbin/watchdog_tmp_sec
            watchdog_tmp_sec_md5="`md5sum /usr/local/sbin/watchdog_tmp_sec | awk '{print $1}'`"
            if [ "$update_watchdog_md5" = "$watchdog_tmp_sec_md5" ];then
                    if [ -s /usr/local/sbin/watchdog_tmp_sec ];then
                        stop_watchdog
                        rm -rf /usr/local/sbin/watchdog
                        mv /usr/local/sbin/watchdog_tmp_sec /usr/local/sbin/watchdog
                        start_watchdog
                    fi
            fi
        fi
    fi
fi


md5sum /usr/local/sbin/watchdog 2>&1|awk '{print $1}' > /home/update/puppetmd5file/md5-watchdog
