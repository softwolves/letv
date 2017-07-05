#!/bin/bash
#Power by duhaibin@letv.com
#2015-07-17 16:32:28
#通过ansible升级cagent二进制文件
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
lockfile="/var/run/ansible_update_cagent.pid"

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


stop_cagent() {
        killall -9 cagent
        sleep 2
        killall -9 cagent
        sleep 1
        killall -9 cagent
}

start_cagent() {
        chmod 755 /usr/local/sbin/cagent
        /usr/local/sbin/cagent
}

if [ ! -f /usr/local/sbin/cagent ]
then
        touch /usr/local/sbin/cagent
fi

if [ ! -d /home/update/puppetmd5file ]
then
        mkdir -p /home/update/puppetmd5file
        mkdir -p /home/update/file
	mkdir -p /home/update/shell
fi


download_cloud="test.coop.gslb.letv.com"
download_all="115.182.94.72"
update_cagent_md5="`cat /home/update/puppetmd5file/md5-cagent`"
run_cagent_md5="`md5sum /usr/local/sbin/cagent | awk '{print $1}'`"
filename_update="cagent_${update_cagent_md5}"
filename_run="cagent_${run_cagent_md5}"

if [ "$filename_update" != "$filename_run" ]
then
#########判断备份目录是否有当前运行的cagent，如果没有就备份一下
    if [ ! -f /home/update/file/${filename_run} ];then
        cp -f /usr/local/sbin/cagent /home/update/file/${filename_run}
        ls -lt /home/update/file/cagent_*| awk '{print $NF}' |sed -n '8,$p'| xargs -i rm -rf {}
    fi    

#########检查备份目录是否有要更新的文件
    if [ -f /home/update/file/${filename_update} ];then
        cagent_bak_md5="`md5sum /home/update/file/${filename_update} | awk '{print $1}'`"
        chmod 755 /home/update/file/${filename_update}
        if [ "$update_cagent_md5" = "$cagent_bak_md5" ];then
		stop_cagent
		rm -rf /usr/local/sbin/cagent
                cp -f /home/update/file/${filename_update} /usr/local/sbin/cagent
		start_cagent
        else
            mv -f /home/update/file/${filename_update} /home/update/file/cagent_${cagent_bak_md5} 
        fi
    else
        rm -rf /usr/local/sbin/cagent_tmp
        wget -t 2 -T 30 -c -N -q -O /usr/local/sbin/cagent_tmp http://$download_cloud/update/${filename_update}
        cagent_tmp_md5="`md5sum /usr/local/sbin/cagent_tmp | awk '{print $1}'`"
        chmod 755 /usr/local/sbin/cagent_tmp
        if [ "$update_cagent_md5" = "$cagent_tmp_md5" ]
        then
                if [ -s /usr/local/sbin/cagent_tmp ];then
                    stop_cagent
                    rm -rf /usr/local/sbin/cagent
                    mv /usr/local/sbin/cagent_tmp /usr/local/sbin/cagent
                    start_cagent
                fi
        else
            wget -t 2 -T 30 -c -N -q -O /usr/local/sbin/cagent_tmp_sec http://$download_all/update/${filename_update}
            chmod 755 /usr/local/sbin/cagent_tmp_sec
            cagent_tmp_sec_md5="`md5sum /usr/local/sbin/cagent_tmp_sec | awk '{print $1}'`"
            if [ "$update_cagent_md5" = "$cagent_tmp_sec_md5" ];then
                    if [ -s /usr/local/sbin/cagent_tmp_sec ];then
                        stop_cagent
                        rm -rf /usr/local/sbin/cagent
                        mv /usr/local/sbin/cagent_tmp_sec /usr/local/sbin/cagent
                        start_cagent
                    fi
            fi
        fi
    fi
fi


md5sum /usr/local/sbin/cagent 2>&1|awk '{print $1}' > /home/update/puppetmd5file/md5-cagent
