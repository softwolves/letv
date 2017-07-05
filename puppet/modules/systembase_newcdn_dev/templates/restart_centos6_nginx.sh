#/bin/bash
#power by jihaipeng@letv.com
#Last edit date 2016-01-06 04:28:59 PM
unset HISTFILE
PATH="/usr/kerberos/sbin:/usr/kerberos/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin"
export PATH
export LANG="en_CN.UTF-8"
run_date=`date '+%Y-%m-%d %H:%M:%S'`
lockfile='/var/run/restart_centos6_nginx.pid'

#检查livemem是否挂载，如果挂载则将其卸载
tag=`df -h|grep livemem`
if [[ $tag != "" ]];then
        umount /livemem
fi

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
}

restart_nginx(){
    killall -9 nginx
    killall -9 watchdog
    while `ps aux |grep 'nginx:' |grep -qv grep `
    do
        killall -9 nginx
        killall -9 watchdog
        sleep 2
    done
    /usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf;/usr/local/sbin/watchdog
}

check_nginx_file

if ! nc -z -r 127.0.0.1 80 >/dev/null;then
    restart_nginx
    stage="restart nginx:no port for nginx"
    print_log >>/home/lihongfu/servicelog
else
    if ! curl -q -m 60 http://localhost/NginxStatus/ >/dev/null 2>&1;then
        restart_nginx
        stage="restart nginx:can't provide service for curl"
        print_log >>/home/lihongfu/servicelog
    fi    
fi


md5sum /usr/local/nginx/sbin/nginx 2>&1|awk '{print $1}' >/home/update/puppetmd5file/md5-nginx
