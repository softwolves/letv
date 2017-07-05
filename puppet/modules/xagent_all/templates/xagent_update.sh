#!/bin/bash
#Power by duhaibin@letv.com
#2015-07-17 16:32:28
#通过ansible升级xagent二进制文件
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
lockfile="/var/run/ansible_update_xagent.pid"

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


stop_xagent() {
        killall -9 xagent
        sleep 2
        killall -9 xagent
        sleep 1
        killall -9 xagent
}

start_xagent() {
        chmod 755 /usr/local/sbin/xagent
#        /usr/local/sbin/xagent -reportTime=300  -reportUrl="http://115.182.63.185:8080/v1" &
	/usr/local/sbin/xagent -reportTime=300  -reportUrl="http://api.autocdn.letv.cn/v1" &
}

if [ ! -f /usr/local/sbin/xagent ]
then
        touch /usr/local/sbin/xagent
fi

if [ ! -d /home/update/puppetmd5file ]
then
        mkdir -p /home/update/puppetmd5file
        mkdir -p /home/update/file
	mkdir -p /home/update/shell
fi


download_cloud="test.coop.gslb.letv.com"
download_all="115.182.94.72"
update_xagent_md5="`cat /home/update/puppetmd5file/md5-xagent`"
run_xagent_md5="`md5sum /usr/local/sbin/xagent | awk '{print $1}'`"
filename_update="xagent_${update_xagent_md5}"
filename_run="xagent_${run_xagent_md5}"

if [ "$filename_update" != "$filename_run" ]
then
#########判断备份目录是否有当前运行的xagent，如果没有就备份一下
    if [ ! -f /home/update/file/${filename_run} ];then
        cp -f /usr/local/sbin/xagent /home/update/file/${filename_run}
        ls -lt /home/update/file/xagent_*| awk '{print $NF}' |sed -n '8,$p'| xargs -i rm -rf {}
    fi    

#########检查备份目录是否有要更新的文件
    if [ -f /home/update/file/${filename_update} ];then
        xagent_bak_md5="`md5sum /home/update/file/${filename_update} | awk '{print $1}'`"
        chmod 755 /home/update/file/${filename_update}
        if [ "$update_xagent_md5" = "$xagent_bak_md5" ];then
		stop_xagent
		rm -rf /usr/local/sbin/xagent
                cp -f /home/update/file/${filename_update} /usr/local/sbin/xagent
		start_xagent
        else
            mv -f /home/update/file/${filename_update} /home/update/file/xagent_${xagent_bak_md5} 
        fi
    else
        rm -rf /usr/local/sbin/xagent_tmp
        wget -t 2 -T 30 -c -N -q -O /usr/local/sbin/xagent_tmp http://$download_cloud/update/${filename_update}
        xagent_tmp_md5="`md5sum /usr/local/sbin/xagent_tmp | awk '{print $1}'`"
        chmod 755 /usr/local/sbin/xagent_tmp
        if [ "$update_xagent_md5" = "$xagent_tmp_md5" ]
        then
                if [ -s /usr/local/sbin/xagent_tmp ];then
                    stop_xagent
                    rm -rf /usr/local/sbin/xagent
                    mv /usr/local/sbin/xagent_tmp /usr/local/sbin/xagent
                    start_xagent
                fi
        else
            wget -t 2 -T 30 -c -N -q -O /usr/local/sbin/xagent_tmp_sec http://$download_all/update/${filename_update}
            chmod 755 /usr/local/sbin/xagent_tmp_sec
            xagent_tmp_sec_md5="`md5sum /usr/local/sbin/xagent_tmp_sec | awk '{print $1}'`"
            if [ "$update_xagent_md5" = "$xagent_tmp_sec_md5" ];then
                    if [ -s /usr/local/sbin/xagent_tmp_sec ];then
                        stop_xagent
                        rm -rf /usr/local/sbin/xagent
                        mv /usr/local/sbin/xagent_tmp_sec /usr/local/sbin/xagent
                        start_xagent
                    fi
            fi
        fi
    fi
fi


md5sum /usr/local/sbin/xagent 2>&1|awk '{print $1}' > /home/update/puppetmd5file/md5-xagent
