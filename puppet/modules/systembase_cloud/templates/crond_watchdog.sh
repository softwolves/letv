#!/bin/bash
#Power by jihaipeng@letv.com
#Last edit Wed Mar  2 14:45:52 CST 2016
#restart watchdog
PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/games:/usr/local/sbin:/usr/local/bin:/root/bin
sleep $((RANDOM%1800+1))
#重启前校验nginx配置是否正确
if /usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf -t >/dev/null 2>&1;then
    while `ps aux |grep '/usr/local/sbin/watchdog' |grep -qv grep `
    do
        killall -9 watchdog
        sleep 2
    done
    /usr/local/sbin/watchdog
fi
