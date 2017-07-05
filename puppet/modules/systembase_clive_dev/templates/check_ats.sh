#!/bin/bash
#power by duhaibin@letv.com
#ramsize=`/usr/local/sbin/ats/bin/traffic_line -r proxy.config.cache.ram_cache.size`
#memsize=`cat /proc/meminfo|grep MemTotal | awk '{print $2}'`
#if [ "$memsize" -lt "13180708" ];then
#        if [ "$ramsize" -ne "1073741824" ] ;then
#                /usr/local/sbin/ats/bin/traffic_line -s proxy.config.cache.ram_cache.size -v 1073741824
#                /usr/local/sbin/ats/bin/traffic_line -x
#        fi
#elif [ "$memsize" -gt "13180708" ];then
#        if [ "$ramsize" -ne "3221225472" ] ;then
#                /usr/local/sbin/ats/bin/traffic_line -s proxy.config.cache.ram_cache.size -v 3221225472
#                /usr/local/sbin/ats/bin/traffic_line -x
#        fi
#
#fi
if ! ps aux | grep  traffic_cop | grep -v grep >/dev/null 2>&1;then
        /usr/local/sbin/ats/bin/trafficserver restart
	md5sum /home/lihongfu/update/letv_trafficserver.tar.gz 2>&1|awk '{print $1}' >/letv/soft/nginx/md5-ats
fi

#if ! ps aux | grep cagent | grep -v grep >/dev/null 2>&1;then
#        /usr/local/sbin/cagent
#	md5sum /usr/local/sbin/cagent 2>&1|awk '{print $1}' >/letv/soft/watchdog/md5-cagent
#fi

ps -ef | grep   /usr/local/sbin/pinger | grep -v grep &> /dev/null
if [ $? -ne 0 ];then
	pkill pinger
	sleep 1
        rm -rf /var/run/pinger.pid
	#/usr/local/sbin/pinger --daemon --ping-retention=72h --db=/letv/fet/greenping/db --tag=/letv/fet/greenping/tag --center=ws://greenping.g3gather.lecloud.com/register
        #/usr/local/sbin/pinger -center ws://greenping.g3gather.lecloud.com/register?iplist=
	#/usr/local/sbin/pinger --daemon --center=https://117.121.54.101
	/usr/local/sbin/pinger --daemon --center=117.121.54.101:443 --dns-config="dns_addr=127.0.0.1:5053" --api=127.0.0.1:909
elif [ ! -e /var/run/pinger.pid ];then
	pkill pinger
	sleep 1
        #/usr/local/sbin/pinger --daemon --ping-retention=72h --db=/letv/fet/greenping/db --tag=/letv/fet/greenping/tag --center=ws://greenping.g3gather.lecloud.com/register
	#/usr/local/sbin/pinger -center ws://greenping.g3gather.lecloud.com/register?iplist=
	#/usr/local/sbin/pinger --daemon --center=https://117.121.54.101
	/usr/local/sbin/pinger --daemon --center=117.121.54.101:443 --dns-config="dns_addr=127.0.0.1:5053" --api=127.0.0.1:909
fi
