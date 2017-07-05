#!/bin/bash
#Power by duhaibin@letv.com
#2015-07-17 16:32:28
#通过ansible升级crtmpserver二进制文件
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
lockfile="/var/run/ansible_update_crtmpserver.pid"

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


if [ ! -f /usr/local/sbin/crtmpserver ]
then
        touch /usr/local/sbin/crtmpserver
fi

if [ ! -d /home/update/puppetmd5file ]
then
        mkdir -p /home/update/puppetmd5file
        mkdir -p /home/update/file
	mkdir -p /home/update/shell
fi

pidfile=/var/run/crtmpserver.pid
download_cloud="test.coop.gslb.letv.com"
download_all="115.182.94.72"
update_crtmpserver_md5="`cat /home/update/puppetmd5file/md5-crtmpserver`"
run_crtmpserver_md5="`md5sum /usr/local/sbin/crtmpserver | awk '{print $1}'`"
filename_update="crtmpserver_${update_crtmpserver_md5}"
filename_run="crtmpserver_${run_crtmpserver_md5}"

if [ "$filename_update" != "$filename_run" ]
then
#########判断备份目录是否有当前运行的crtmpserver，如果没有就备份一下
    if [ ! -f /home/update/file/${filename_run} ];then
        cp -f /usr/local/sbin/crtmpserver /home/update/file/${filename_run}
        ls -lt /home/update/file/crtmpserver_*| awk '{print $NF}' |sed -n '8,$p'| xargs -i rm -rf {}
    fi    

#########检查备份目录是否有要更新的文件
    if [ -f /home/update/file/${filename_update} ];then
        crtmpserver_bak_md5="`md5sum /home/update/file/${filename_update} | awk '{print $1}'`"
        chmod 755 /home/update/file/${filename_update}
        if [ "$update_crtmpserver_md5" = "$crtmpserver_bak_md5" ];then
		rm -rf /usr/local/sbin/crtmpserver
		cd /home/update/core/
                cp -f /home/update/file/${filename_update} /usr/local/sbin/crtmpserver
                killall -9 crtmpserver
                killall -9 rtmp2http
                sleep 1
                killall -9 crtmpserver
                killall -9 rtmp2http
                sleep 1
                chown www.root $pidfile
                chmod 755 /usr/local/sbin/crtmpserver
                /usr/local/sbin/crtmpserver --pid=/var/run/crtmpserver.pid /usr/local/etc/crtmpserver.cdn.lua

        else
            mv -f /home/update/file/${filename_update} /home/update/file/crtmpserver_${crtmpserver_bak_md5} 
        fi
    else
        rm -rf /usr/local/sbin/crtmpserver_tmp
        wget -t 2 -T 30 -c -N -q -O /usr/local/sbin/crtmpserver_tmp http://$download_cloud/update/${filename_update}
        crtmpserver_tmp_md5="`md5sum /usr/local/sbin/crtmpserver_tmp | awk '{print $1}'`"
        chmod 755 /usr/local/sbin/crtmpserver_tmp
        if [ "$update_crtmpserver_md5" = "$crtmpserver_tmp_md5" ]
        then
                if [ -s /usr/local/sbin/crtmpserver_tmp ];then
                	rm -rf /usr/local/sbin/crtmpserver
                	cd /home/update/core/
                	mv /usr/local/sbin/crtmpserver_tmp /usr/local/sbin/crtmpserver

                	killall -9 crtmpserver
                	killall -9 rtmp2http
                	sleep 1
                	killall -9 crtmpserver
                	killall -9 rtmp2http
                	sleep 1
                	chown www.root $pidfile
                	chmod 755 /usr/local/sbin/crtmpserver
                	/usr/local/sbin/crtmpserver --pid=/var/run/crtmpserver.pid /usr/local/etc/crtmpserver.cdn.lua
                fi
        else
            wget -t 2 -T 30 -c -N -q -O /usr/local/sbin/crtmpserver_tmp_sec http://$download_all/update/${filename_update}
            chmod 755 /usr/local/sbin/crtmpserver_tmp_sec
            crtmpserver_tmp_sec_md5="`md5sum /usr/local/sbin/crtmpserver_tmp_sec | awk '{print $1}'`"
            if [ "$update_crtmpserver_md5" = "$crtmpserver_tmp_sec_md5" ];then
                    if [ -s /usr/local/sbin/crtmpserver_tmp_sec ];then
			cd /home/update/core/
                        killall -9 crtmpserver
                        killall -9 rtmp2http
                        sleep 1
                        killall -9 crtmpserver
                        killall -9 rtmp2http
                        sleep 1
                        rm -rf /usr/local/sbin/crtmpserver
                        mv /usr/local/sbin/crtmpserver_tmp_sec /usr/local/sbin/crtmpserver
                        chmod 755 /usr/local/sbin/crtmpserver
                        chown www.root $pidfile
                        /usr/local/sbin/crtmpserver --pid=/var/run/crtmpserver.pid /usr/local/etc/crtmpserver.cdn.lua
                    fi
            fi
        fi
    fi
fi


md5sum /usr/local/sbin/crtmpserver 2>&1|awk '{print $1}' > /home/update/puppetmd5file/md5-crtmpserver
