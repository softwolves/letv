#!/bin/bash
#Power by duhaibin@letv.com
#2015-07-17 16:32:28
#通过ansible升级ctod二进制文件
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
lockfile="/var/run/ansible_update_ctod.pid"

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


stop_ctod() {
        /etc/init.d/cto2.3 stop
        sleep 1
        /etc/init.d/cto2.3 stop

}

start_ctod() {
        /etc/init.d/cto2.3 restart
}

if [ ! -f /cto2/ctod ]
then
        touch /cto2/ctod
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
update_ctod_md5="`cat /home/update/puppetmd5file/md5-ctod`"
run_ctod_md5="`md5sum /cto2/ctod | awk '{print $1}'`"
filename_update="ctod_${update_ctod_md5}"
filename_run="ctod_${run_ctod_md5}"

if [ "$filename_update" != "$filename_run" ]
then
#########判断备份目录是否有当前运行的ctod，如果没有就备份一下
    if [ ! -f /home/update/file/${filename_run} ];then
        cp -f /cto2/ctod /home/update/file/${filename_run}
        ls -lt /home/update/file/ctod_*| awk '{print $NF}' |sed -n '8,$p'| xargs -i rm -rf {}
    fi    

#########检查备份目录是否有要更新的文件
    if [ -f /home/update/file/${filename_update} ];then
        ctod_bak_md5="`md5sum /home/update/file/${filename_update} | awk '{print $1}'`"
        chmod 755 /home/update/file/${filename_update}
        if [ "$update_ctod_md5" = "$ctod_bak_md5" ];then
		stop_ctod
		rm -rf /cto2/ctod
                cp -f /home/update/file/${filename_update} /cto2/ctod
                chmod 755 /cto2/ctod
		start_ctod
        else
            mv -f /home/update/file/${filename_update} /home/update/file/ctod_${ctod_bak_md5} 
        fi
    else
        rm -rf /cto2/ctod_tmp
        wget -t 2 -T 30 -c -N -q -O /cto2/ctod_tmp http://$download_cloud/update/${filename_update}
        ctod_tmp_md5="`md5sum /cto2/ctod_tmp | awk '{print $1}'`"
        chmod 755 /cto2/ctod_tmp
        if [ "$update_ctod_md5" = "$ctod_tmp_md5" ]
        then
                if [ -s /cto2/ctod_tmp ];then
                    stop_ctod
                    rm -rf /cto2/ctod
                    mv /cto2/ctod_tmp /cto2/ctod
                    chmod 755 /cto2/ctod
                    start_ctod
                fi
        else
            wget -t 2 -T 30 -c -N -q -O /cto2/ctod_tmp_sec http://$download_all/update/${filename_update}
            chmod 755 /cto2/ctod_tmp_sec
            ctod_tmp_sec_md5="`md5sum /cto2/ctod_tmp_sec | awk '{print $1}'`"
            if [ "$update_ctod_md5" = "$ctod_tmp_sec_md5" ];then
                    if [ -s /cto2/ctod_tmp_sec ];then
                        stop_ctod
                        rm -rf /cto2/ctod
                        mv /cto2/ctod_tmp_sec /cto2/ctod
			chmod 755 /cto2/ctod
                        start_ctod
                    fi
            fi
        fi
    fi
fi


md5sum /cto2/ctod 2>&1|awk '{print $1}' > /home/update/puppetmd5file/md5-ctod
