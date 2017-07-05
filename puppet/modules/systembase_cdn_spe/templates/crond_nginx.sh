#!/bin/bash
#Power by jihaipeng@letv.com
#Last edit 2016-01-06 10:34:11 AM
PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/games:/usr/local/sbin:/usr/local/bin:/root/bin
sleep $((RANDOM%1800+1))
#重启前校验nginx配置是否正确
if /usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf -t >/dev/null 2>&1;then
#####重启traffic进程
    pkill -9 traffic
    pkill -9 traffic
    /usr/local/sbin/ats/bin/trafficserver restart
    killall -9 nginx
    killall -9 nginx
    sleep 2
    while `ps aux |grep '/usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf' |grep -qv grep `
    do
        killall -9 nginx
        sleep 2
    done
    /usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf
    while `ps aux |grep '/usr/local/sbin/watchdog' |grep -qv grep `
    do
        killall -9 watchdog
        sleep 2
    done
    /usr/local/sbin/watchdog
fi
if /usr/local/openresty/nginx/sbin/openresty -c /usr/local/openresty/nginx/conf/nginx.conf -t  >/dev/null 2>&1;then
    killall -9 openresty
    sleep 2
    /usr/local/openresty/nginx/sbin/openresty -c /usr/local/openresty/nginx/conf/nginx.conf
fi
/etc/init.d/puppetd restart &> /dev/null
