#!/bin/bash
#Power by duhaibin@letv.com
#2015-07-17 16:32:28
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
lockfile="/var/run/ansible_update_watchdog2.pid"

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
        killall -9 watchdog2
        sleep 2
        killall -9 watchdog2
        sleep 1
        killall -9 watchdog2
}

start_watchdog() {
        chmod 755 /usr/local/bin/watchdog2
        ulimit -c unlimited
        /etc/init.d/watchdog2 restart
}

if [ ! -f /usr/local/bin/watchdog2 ]
then
        touch /usr/local/bin/watchdog2
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
update_watchdog_md5="`cat /home/update/puppetmd5file/md5-watchdog2`"
run_watchdog_md5="`md5sum /usr/local/bin/watchdog | awk '{print $1}'`"
filename_update="watchdog2_${update_watchdog_md5}"
filename_run="watchdog2_${run_watchdog_md5}"

if [ "$filename_update" != "$filename_run" ]
then
#########判断备份目录是否有当前运行的watchdog，如果没有就备份一下
    if [ ! -f /home/update/file/${filename_run} ];then
        cp -f /usr/local/bin/watchdog2 /home/update/file/${filename_run}
        ls -lt /home/update/file/watchdog2_*| awk '{print $NF}' |sed -n '8,$p'| xargs -i rm -rf {}
    fi    

#########检查备份目录是否有要更新的文件
    if [ -f /home/update/file/${filename_update} ];then
        watchdog_bak_md5="`md5sum /home/update/file/${filename_update} | awk '{print $1}'`"
        chmod 755 /home/update/file/${filename_update}
        if [ "$update_watchdog_md5" = "$watchdog_bak_md5" ];then
		rm -rf /usr/local/bin/watchdog2
                cp -f /home/update/file/${filename_update} /usr/local/bin/watchdog2
		start_watchdog
        else
            mv -f /home/update/file/${filename_update} /home/update/file/watchdog2_${watchdog_bak_md5} 
        fi
    else
        rm -rf /usr/local/bin/watchdog2_tmp
        wget -t 2 -T 30 -c -N -q -O /usr/local/bin/watchdog2_tmp http://$download_cloud/update/${filename_update}
        watchdog_tmp_md5="`md5sum /usr/local/bin/watchdog2_tmp | awk '{print $1}'`"
        chmod 755 /usr/local/bin/watchdog2_tmp
        if [ "$update_watchdog_md5" = "$watchdog_tmp_md5" ]
        then
                if [ -s /usr/local/bin/watchdog2_tmp ];then
                    rm -rf /usr/local/bin/watchdog2
                    mv /usr/local/bin/watchdog2_tmp /usr/local/bin/watchdog2
                    start_watchdog
                fi
        else
            wget -t 2 -T 30 -c -N -q -O /usr/local/bin/watchdog2_tmp_sec http://$download_all/update/${filename_update}
            chmod 755 /usr/local/bin/watchdog2_tmp_sec
            watchdog_tmp_sec_md5="`md5sum /usr/local/bin/watchdog2_tmp_sec | awk '{print $1}'`"
            if [ "$update_watchdog_md5" = "$watchdog_tmp_sec_md5" ];then
                    if [ -s /usr/local/bin/watchdog2_tmp_sec ];then
                        rm -rf /usr/local/bin/watchdog2
                        mv /usr/local/bin/watchdog2_tmp_sec /usr/local/bin/watchdog2
                        start_watchdog
                    fi
            fi
        fi
    fi
fi


md5sum /usr/local/bin/watchdog2 2>&1|awk '{print $1}' > /home/update/puppetmd5file/md5-watchdog2
