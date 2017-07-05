#/bin/bash
#power by duhaibin@letv.com
#Last edit date 2014年 3月 6日 星期四 10时17分42秒 CST
unset HISTFILE
PATH="/usr/kerberos/sbin:/usr/kerberos/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin"
export PATH
export LANG="en_CN.UTF-8"
run_date=`date '+%Y-%m-%d %H:%M:%S'`
lockfile='/var/run/restart_centos6_nginx.pid'
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

print_log(){
printf '%100s\n' | tr ' ' =
echo "$run_date : restart nginx by $stage"
printf '%100s\n' | tr ' ' =
}

check_nginx_file(){
	if [ -f /usr/local/nginx/sbin/nginx ];then
               tag1=`ls -l /usr/local/nginx/sbin/nginx | awk '{print $1}'`
               if [ ${tag1} != "-rwxr-xr-x" ];then
                       chmod 755 /usr/local/nginx/sbin/nginx
               fi
	fi
	if [ ! -d /letv/fet/live/live_temp ];then
		mkdir -p /letv/fet/live/live_temp
	fi
        if [ ! -d /livemem/live/live_temp  ];then
                mkdir -p /livemem/live/live_temp
        fi
#	if [ ! -f /usr/local/sbin/nginx ];then
#		unset HISTFILE;rm -rf /var/lib/puppet/state/puppetdlock;killall -9 puppetd ;puppetd --test --server puppet.oss.letv.com
#	else
#                tag1=`ls -l /usr/local/sbin/nginx | awk '{print $1}'`
#		if [ ${tag1} != "-rwxr-xr-x" ];then
#			chmod 755 /usr/local/sbin/nginx
#		fi
#	fi
	

}

mount_livemem(){
        livemem_mount_type="`mount |grep livemem |awk '{print $5}'`"
        livemem_type="tmpfs"

        if [ "$livemem_mount_type" != "$livemem_type"  ]
        then
                        killall -9 nginx
                        killall -9 watchdog
                        sleep 2
                        umount /livemem
                        umount /livemem
                        if [ ! -d /livemem ]
                        then
                        mkdir  /livemem
                        fi
                        mount |grep livemem 2>&1 >/dev/null
                        if [ $? -eq 0 ]
                        then
                        if [ ! -d /livemem/live/live_temp ]
                        then
                        mkdir -p /livemem/live/live_temp
                        fi
                        else
#                        mount -t tmpfs -o size=3G,mode=0755 tmpfs /livemem
			mount -t tmpfs -o size=$(cat /proc/meminfo|grep MemTotal|awk '{printf"%d",$2/1000000-10}')G,mode=0755 tmpfs /livemem
                        if [ ! -d /livemem/live/live_temp ]
                        then
                        mkdir -p /livemem/live/live_temp
                        fi
                        fi
	fi
}

restart_nginx(){
                while `ps aux |grep 'nginx:' |grep -qv grep `
                do
                        killall -9 nginx
                        killall -9 watchdog
		done
		/usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf;/usr/local/sbin/watchdog

}

check_nginx_file
mount_livemem

if ! nc -z -r 127.0.0.1 80 >/dev/null;then
	restart_nginx
        stage="restart nginx:no port for nginx"
        print_log >>/home/lihongfu/servicelog
else
	if ! curl -q -m 60 http://localhost/NginxStatus/a >/dev/null 2>&1;then
		restart_nginx
		stage="restart nginx:can't provide service for curl"
		print_log >>/home/lihongfu/servicelog
	else
#		if [ `find /usr/local/letv/access.log -mmin -1|wc -l` -ne 1 ];then
#			restart_nginx
#                	stage="restart nginx:can't find nginx log output"
#                	print_log >>/home/lihongfu/servicelog
#		else
			echo  "nginx status is ok"
#		fi	
	fi	
fi

md5sum /usr/local/nginx/sbin/nginx 2>&1|awk '{print $1}' >/home/update/puppetmd5file/md5-nginx
