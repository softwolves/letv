#!/bin/bash
#Power by duhaibin@letv.com
#2015-07-17 16:32:28
#通过ansible升级nginx二进制文件
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
lockfile="/var/run/ansible_update_nginx.pid"

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


if [ ! -f /usr/local/nginx/sbin/nginx ]
then
        touch /usr/local/nginx/sbin/nginx
fi

if [ ! -d /home/update/puppetmd5file ]
then
        mkdir -p /home/update/puppetmd5file
        mkdir -p /home/update/file
	mkdir -p /home/update/shell
fi
##########平滑升级nginx二进制########
nginx_restart(){
if ps aux | grep -v grep | grep -E "/usr/local/sbin/nginx -c /usr/local/etc/nginx.conf" >/dev/null 2>&1 ;then
    killall -9 nginx
fi
if [ -f /usr/local/nginx/logs/nginx.pid.oldbin ];then
        kill -TERM `cat /usr/local/nginx/logs/nginx.pid.oldbin`
        sleep 1
        kill -USR2 `cat /usr/local/nginx/logs/nginx.pid`
        sleep 1
        kill -WINCH `cat /usr/local/nginx/logs/nginx.pid.oldbin`
        sleep 1
        kill -QUIT `cat /usr/local/nginx/logs/nginx.pid.oldbin`
else
        kill -USR2 `cat /usr/local/nginx/logs/nginx.pid`
        sleep 1
        kill -WINCH `cat /usr/local/nginx/logs/nginx.pid.oldbin`
        sleep 1
        kill -QUIT `cat /usr/local/nginx/logs/nginx.pid.oldbin`
fi
}
####################################

download_cloud="test.coop.gslb.letv.com"
download_all="115.182.94.72"
update_nginx_md5="`cat /home/update/puppetmd5file/md5-nginx`"
run_nginx_md5="`md5sum /usr/local/nginx/sbin/nginx | awk '{print $1}'`"
filename_update="nginx_${update_nginx_md5}"
filename_run="nginx_${run_nginx_md5}"

if [ "$filename_update" != "$filename_run" ]
then
#########判断备份目录是否有当前运行的nginx，如果没有就备份一下
    if [ ! -f /home/update/file/${filename_run} ];then
        cp -f /usr/local/sbin/nginx /home/update/file/${filename_run}
        ls -lt /home/update/file/nginx_*| awk '{print $NF}' |sed -n '8,$p'| xargs -i rm -rf {}
    fi    

#########检查备份目录是否有要更新的文件
    if [ -f /home/update/file/${filename_update} ];then
        nginx_bak_md5="`md5sum /home/update/file/${filename_update} | awk '{print $1}'`"
        chmod 755 /home/update/file/${filename_update}
        if [ "$update_nginx_md5" = "$nginx_bak_md5" ];then
            if /home/update/file/${filename_update} -c /usr/local/nginx/conf/nginx.conf -t >/dev/null 2>&1;then
                cp -f /home/update/file/${filename_update} /usr/local/nginx/sbin/nginx
                chmod 755 /usr/local/nginx/sbin/nginx
                if [ -f /usr/local/sbin/nginx ];then
                        rm -f /usr/local/sbin/nginx
                fi
		nginx_restart
            fi
        else
            mv -f /home/update/file/${filename_update} /home/update/file/nginx_${nginx_bak_md5} 
        fi
    else
        old_nginx_tmp="`md5sum /usr/local/sbin/nginx_tmp | awk '{print $1}'`"
        if [ "$update_nginx_md5" != "$old_nginx_tmp" ];then
        	rm -rf /usr/local/nginx/sbin/nginx_tmp
        	wget -t 2 -T 30 -c -N -q -O /usr/local/nginx/sbin/nginx_tmp http://$download_cloud/update/${filename_update}
	fi
        nginx_tmp_md5="`md5sum /usr/local/nginx/sbin/nginx_tmp | awk '{print $1}'`"
        chmod 755 /usr/local/nginx/sbin/nginx_tmp
        if [ "$update_nginx_md5" = "$nginx_tmp_md5" ]
        then
            if /usr/local/nginx/sbin/nginx_tmp -c /usr/local/nginx/conf/nginx.conf -t >/dev/null 2>&1;then
                if [ -s /usr/local/nginx/sbin/nginx_tmp ];then
                    mv -f /usr/local/nginx/sbin/nginx /usr/local/nginx/sbin/nginx_bak
                    mv -f /usr/local/nginx/sbin/nginx_tmp /usr/local/nginx/sbin/nginx
                    chmod 755 /usr/local/nginx/sbin/nginx
                    if [ -f /usr/local/sbin/nginx ];then
                        rm -f /usr/local/sbin/nginx
                    fi
		    nginx_restart
                fi
            fi
        else
            old_nginx_tmp_sec="`md5sum /usr/local/nginx/sbin/nginx_tmp_sec | awk '{print $1}'`"
            if [ "$update_nginx_md5" != "$old_nginx_tmp_sec" ];then
                rm -rf /usr/local/nginx/sbin/nginx_tmp_sec
                wget -t 2 -T 30 -c -N -q -O /usr/local/nginx/sbin/nginx_tmp_sec http://$download_all/update/${filename_update}
            fi
            chmod 755 /usr/local/nginx/sbin/nginx_tmp_sec
            nginx_tmp_sec_md5="`md5sum /usr/local/nginx/sbin/nginx_tmp_sec | awk '{print $1}'`"
            if [ "$update_nginx_md5" = "$nginx_tmp_sec_md5" ];then
                if /usr/local/nginx/sbin/nginx_tmp_sec -c /usr/local/nginx/conf/nginx.conf -t >/dev/null 2>&1;then
                    if [ -s /usr/local/nginx/sbin/nginx_tmp_sec ];then
                        mv -f /usr/local/nginx/sbin/nginx /usr/local/nginx/sbin/nginx_bak
                        mv -f /usr/local/nginx/sbin/nginx_tmp_sec /usr/local/nginx/sbin/nginx
                        chmod 755 /usr/local/nginx/sbin/nginx
                        if [ -f /usr/local/sbin/nginx ];then
                            rm -f /usr/local/sbin/nginx
                        fi
			nginx_restart
                    fi
                fi
            fi
        fi
    fi
fi


md5sum /usr/local/nginx/sbin/nginx 2>&1|awk '{print $1}' > /home/update/puppetmd5file/md5-nginx
