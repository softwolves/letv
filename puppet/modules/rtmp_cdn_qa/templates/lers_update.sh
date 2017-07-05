#!/bin/bash
#Power by duhaibin@letv.com
#2015-07-17 16:32:28
#通过ansible升级lers二进制文件
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
lockfile="/var/run/ansible_update_lers.pid"

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


if [ ! -f /usr/local/sbin/lers ]
then
        touch /usr/local/sbin/lers
fi

if [ ! -f /usr/local/sbin/lers_proxy ]
then
        touch /usr/local/sbin/lers_proxy
fi

if [ ! -d /home/update/puppetmd5file ]
then
        mkdir -p /home/update/puppetmd5file
        mkdir -p /home/update/file
	mkdir -p /home/update/shell
fi


#[1] lers_proxy更新#######################

download_cloud="test.coop.gslb.letv.com"
download_all="115.182.94.72"
update_lers_md5="`cat /home/update/puppetmd5file/md5-lers_proxy`"
run_lers_md5="`md5sum /usr/local/sbin/lers_proxy | awk '{print $1}'`"
filename_update="lers_proxy_${update_lers_md5}"
filename_run="lers_proxy_${run_lers_md5}"

if [ "$filename_update" != "$filename_run" ]   #运行的非需要升级的，要操作升级
then
#########判断备份目录是否有当前运行的lers_proxy，如果没有就备份一下
    if [ ! -f /home/update/file/${filename_run} ];then
        cp -f /usr/local/sbin/lers_proxy /home/update/file/${filename_run}
        ls -lt /home/update/file/lers_proxy_*| awk '{print $NF}' |sed -n '8,$p'| xargs -i rm -rf {}
    fi

#########检查备份目录是否有要更新的文件
    if [ -f /home/update/file/${filename_update} ];then 
        lers_bak_md5="`md5sum /home/update/file/${filename_update} | awk '{print $1}'`"
        chmod 755 /home/update/file/${filename_update}
        if [ "$update_lers_md5" = "$lers_bak_md5" ];then   #确认bak为需要升级的文件,升级
		rm -rf /usr/local/sbin/lers_proxy
		cd /home/update/core/
                cp -f /home/update/file/${filename_update} /usr/local/sbin/lers_proxy
                killall -9 lers_proxy
                sleep 1
                chmod 755 /usr/local/sbin/lers_proxy
        else  #如果bak不是需要升级的文件，则备份 
            mv -f /home/update/file/${filename_update} /home/update/file/lers_proxy_${lers_bak_md5}
        fi
    else   #如果没有下载，则下载
        rm -rf /usr/local/sbin/lers_proxy_tmp
        #第一次通过cloud下载
        wget -t 2 -T 30 -c -N -q -O /usr/local/sbin/lers_proxy_tmp http://$download_cloud/update/${filename_update}
        lers_tmp_md5="`md5sum /usr/local/sbin/lers_proxy_tmp | awk '{print $1}'`"
        chmod 755 /usr/local/sbin/lers_proxy_tmp
        if [ "$update_lers_md5" = "$lers_tmp_md5" ]
        then
                if [ -s /usr/local/sbin/lers_proxy_tmp ];then
                	rm -rf /usr/local/sbin/lers_proxy
                	cd /home/update/core/
                	mv /usr/local/sbin/lers_proxy_tmp /usr/local/sbin/lers_proxy
                        killall -9 lers_proxy
                	sleep 1
                	chmod 755 /usr/local/sbin/lers_proxy
                fi
        else
            #第二次通过跳板机下载
            wget -t 2 -T 30 -c -N -q -O /usr/local/sbin/lers_proxy_tmp_sec http://$download_all/update/${filename_update}
            chmod 755 /usr/local/sbin/lers_proxy_tmp_sec
            lers_tmp_sec_md5="`md5sum /usr/local/sbin/lers_proxy_tmp_sec | awk '{print $1}'`"
            if [ "$update_lers_md5" = "$lers_tmp_sec_md5" ];then
                    if [ -s /usr/local/sbin/lers_proxy_tmp_sec ];then
			cd /home/update/core/
                        killall -9 lers_proxy
                        sleep 1
                        rm -rf /usr/local/sbin/lers_proxy
                        mv /usr/local/sbin/lers_proxy_tmp_sec /usr/local/sbin/lers_proxy
                        chmod 755 /usr/local/sbin/lers_proxy
                    fi
            fi
        fi
    fi
fi

##[2] lers更新#######################

pidfile=/var/run/lers.pid
download_cloud="test.coop.gslb.letv.com"
download_all="115.182.94.72"
update_lers_md5="`cat /home/update/puppetmd5file/md5-lers`"
run_lers_md5="`md5sum /usr/local/sbin/lers | awk '{print $1}'`"
filename_update="lers_${update_lers_md5}"
filename_run="lers_${run_lers_md5}"

if [ "$filename_update" != "$filename_run" ]
then
#########判断备份目录是否有当前运行的lers，如果没有就备份一下
    if [ ! -f /home/update/file/${filename_run} ];then
        cp -f /usr/local/sbin/lers /home/update/file/${filename_run}
        ls -lt /home/update/file/lers_*| awk '{print $NF}' |sed -n '8,$p'| xargs -i rm -rf {}
    fi    

#########检查备份目录是否有要更新的文件
    if [ -f /home/update/file/${filename_update} ];then
        lers_bak_md5="`md5sum /home/update/file/${filename_update} | awk '{print $1}'`"
        chmod 755 /home/update/file/${filename_update}
        if [ "$update_lers_md5" = "$lers_bak_md5" ];then
		rm -rf /usr/local/sbin/lers
		cd /home/update/core/
                cp -f /home/update/file/${filename_update} /usr/local/sbin/lers
                killall -9 crtmpserver 
                killall -9 rtmp2http rtmp2http_1936 rtmp2http_1937 rtmp2http_1938 rtmp2http_1939 rtmp2http_1940 rtmp2http_1941
                sleep 1
                killall -9 crtmpserver 
                killall -9 rtmp2http rtmp2http_1936 rtmp2http_1937 rtmp2http_1938 rtmp2http_1939 rtmp2http_1940 rtmp2http_1941
                sleep 1
                killall -9 lers
                sleep 1
                chown www.root $pidfile
                chmod 755 /usr/local/sbin/lers
                /usr/local/sbin/lers -c /usr/local/etc/lers.cdn.lua

        else
            mv -f /home/update/file/${filename_update} /home/update/file/lers_${lers_bak_md5} 
        fi
    else
        rm -rf /usr/local/sbin/lers_tmp
        wget -t 2 -T 30 -c -N -q -O /usr/local/sbin/lers_tmp http://$download_cloud/update/${filename_update}
        lers_tmp_md5="`md5sum /usr/local/sbin/lers_tmp | awk '{print $1}'`"
        chmod 755 /usr/local/sbin/lers_tmp
        if [ "$update_lers_md5" = "$lers_tmp_md5" ]
        then
                if [ -s /usr/local/sbin/lers_tmp ];then
                	rm -rf /usr/local/sbin/lers
                	cd /home/update/core/
                	mv /usr/local/sbin/lers_tmp /usr/local/sbin/lers

                	killall -9 crtmpserver 
                	killall -9 rtmp2http rtmp2http_1936 rtmp2http_1937 rtmp2http_1938 rtmp2http_1939 rtmp2http_1940 rtmp2http_1941
                	sleep 1
                	killall -9 crtmpserver 
                	killall -9 rtmp2http rtmp2http_1936 rtmp2http_1937 rtmp2http_1938 rtmp2http_1939 rtmp2http_1940 rtmp2http_1941
                        sleep 1
                        killall -9 lers
                	sleep 1
                	chown www.root $pidfile
                	chmod 755 /usr/local/sbin/lers
                        /usr/local/sbin/lers -c /usr/local/etc/lers.cdn.lua
                fi
        else
            wget -t 2 -T 30 -c -N -q -O /usr/local/sbin/lers_tmp_sec http://$download_all/update/${filename_update}
            chmod 755 /usr/local/sbin/lers_tmp_sec
            lers_tmp_sec_md5="`md5sum /usr/local/sbin/lers_tmp_sec | awk '{print $1}'`"
            if [ "$update_lers_md5" = "$lers_tmp_sec_md5" ];then
                    if [ -s /usr/local/sbin/lers_tmp_sec ];then
			cd /home/update/core/
                        killall -9 crtmpserver 
                        killall -9 rtmp2http rtmp2http_1936 rtmp2http_1937 rtmp2http_1938 rtmp2http_1939 rtmp2http_1940 rtmp2http_1941
                        sleep 1
                        killall -9 crtmpserver 
                        killall -9 rtmp2http rtmp2http_1936 rtmp2http_1937 rtmp2http_1938 rtmp2http_1939 rtmp2http_1940 rtmp2http_1941
                        sleep 1
                        killall -9 lers
                        sleep 1
                        rm -rf /usr/local/sbin/lers
                        mv /usr/local/sbin/lers_tmp_sec /usr/local/sbin/lers
                        chmod 755 /usr/local/sbin/lers
                        chown www.root $pidfile
                        /usr/local/sbin/lers -c /usr/local/etc/lers.cdn.lua
                    fi
            fi
        fi
    fi
fi


md5sum /usr/local/sbin/lers 2>&1|awk '{print $1}' > /home/update/puppetmd5file/md5-lers
md5sum /usr/local/sbin/lers_proxy 2>&1|awk '{print $1}' > /home/update/puppetmd5file/md5-lers_proxy
