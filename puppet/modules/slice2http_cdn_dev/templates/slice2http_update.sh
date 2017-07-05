#!/bin/bash
#Power by duhaibin@letv.com
#2015-07-17 16:32:28
#通过ansible升级slice2http二进制文件
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
lockfile="/var/run/ansible_update_slice2http.pid"

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

if [ ! -d /opt/project/slice2http/bin ];then
    mkdir -p /opt/project/slice2http/bin
fi

stop_slice2http() {
        killall -9 slice2http 
        sleep 2
        killall -9 slice2http 
        sleep 1
        killall -9 slice2http 
}

start_slice2http() {
        chmod 755 /opt/project/slice2http/bin/slice2http 
        ulimit -c unlimited
        /opt/project/slice2http/bin/slice2http -D 
}

if [ ! -f /opt/project/slice2http/bin/slice2http ]
then
        touch /opt/project/slice2http/bin/slice2http 
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
update_slice2http_md5="`cat /home/update/puppetmd5file/md5-slice2http`"
run_slice2http_md5="`md5sum /opt/project/slice2http/bin/slice2http | awk '{print $1}'`"
filename_update="slice2http_${update_slice2http_md5}"
filename_run="slice2http_${run_slice2http_md5}"

if [ "$filename_update" != "$filename_run" ]
then
#########判断备份目录是否有当前运行的slice2http，如果没有就备份一下
    if [ ! -f /home/update/file/${filename_run} ];then
        cp -f /opt/project/slice2http/bin/slice2http /home/update/file/${filename_run}
        ls -lt /home/update/file/slice2http_*| awk '{print $NF}' |sed -n '8,$p'| xargs -i rm -rf {}
    fi    

#########检查备份目录是否有要更新的文件
    if [ -f /home/update/file/${filename_update} ];then
        slice2http_bak_md5="`md5sum /home/update/file/${filename_update} | awk '{print $1}'`"
        chmod 755 /home/update/file/${filename_update}
        if [ "$update_slice2http_md5" = "$slice2http_bak_md5" ];then
		stop_slice2http
		rm -rf /opt/project/slice2http/bin/slice2http
                cp -f /home/update/file/${filename_update} /opt/project/slice2http/bin/slice2http
		start_slice2http
        else
            mv -f /home/update/file/${filename_update} /home/update/file/slice2http_${slice2http_bak_md5} 
        fi
    else
        rm -rf /opt/project/slice2http/bin/slice2http_tmp
        wget -t 2 -T 30 -c -N -q -O /opt/project/slice2http/bin/slice2http_tmp http://$download_cloud/update/${filename_update}
        slice2http_tmp_md5="`md5sum /opt/project/slice2http/bin/slice2http_tmp | awk '{print $1}'`"
        chmod 755 /opt/project/slice2http/bin/slice2http_tmp
        if [ "$update_slice2http_md5" = "$slice2http_tmp_md5" ]
        then
                if [ -s /opt/project/slice2http/bin/slice2http_tmp ];then
                    stop_slice2http
                    rm -rf /opt/project/slice2http/bin/slice2http
                    mv /opt/project/slice2http/bin/slice2http_tmp /opt/project/slice2http/bin/slice2http
                    start_slice2http
                fi
        else
            wget -t 2 -T 30 -c -N -q -O /opt/project/slice2http/bin/slice2http_tmp_sec http://$download_all/update/${filename_update}
            chmod 755 /opt/project/slice2http/bin/slice2http_tmp_sec
            slice2http_tmp_sec_md5="`md5sum /opt/project/slice2http/bin/slice2http_tmp_sec | awk '{print $1}'`"
            if [ "$update_slice2http_md5" = "$slice2http_tmp_sec_md5" ];then
                    if [ -s /opt/project/slice2http/bin/slice2http_tmp_sec ];then
                        stop_slice2http
                        rm -rf /opt/project/slice2http/bin/slice2http
                        mv /opt/project/slice2http/bin/slice2http_tmp_sec /opt/project/slice2http/bin/slice2http
                        start_slice2http
                    fi
            fi
        fi
    fi
fi


md5sum /opt/project/slice2http/bin/slice2http 2>&1|awk '{print $1}' > /home/update/puppetmd5file/md5-slice2http
