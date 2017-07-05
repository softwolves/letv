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
num_cop=`ps aux | grep -E '/usr/local/ats/bin/traffic_cop' | grep -Ev grep  | wc -l`
if [ $num_cop -ne 1 ];then
        if [ -f /usr/local/ats/bin/traffic_cop ];then
                pkill -9 traffic
                /etc/init.d/trafficserver restart
        elif ! ps -ef | grep /usr/local/sbin/ats//bin/traffic_cop | grep -v grep &>/dev/null ;then
                /usr/local/sbin/ats//bin/trafficserver restart
        fi

else
        if ps -ef | grep /usr/local/sbin/ats//bin/traffic_cop | grep -v grep &>/dev/null ;then
                /usr/local/sbin/ats//bin/trafficserver stop
                /etc/init.d/trafficserver restart
        fi
        rm -f /letv/fet/ats_data/cache.db
fi

	md5sum /home/lihongfu/update/letv_trafficserver.tar.gz 2>&1|awk '{print $1}' >/letv/soft/nginx/md5-ats



if ! ps aux | grep cagent | grep -v grep >/dev/null 2>&1;then
        /usr/local/sbin/cagent -server=115.182.93.188
fi

if ! ps aux | grep fsserver | grep -v grep >/dev/null 2>&1;then
	pkill -9 flashShitD
	/usr/local/sbin/fsserver_32
fi
#if ! ps aux | grep stress_testing.py | grep -v grep >/dev/null 2>&1;then
#	kill -9 $(ps aux | grep vplayer | grep -v grep | awk '{print $2}')
#	cd /letv/soft/tools/stresstest/stress_test/py/;python stress_testing.py &
#fi

if ! ps aux | grep openresty | grep -v grep >/dev/null 2>&1;then
/usr/local/openresty/nginx/sbin/openresty  -c /usr/local/openresty/nginx/conf/nginx.conf

fi

if [ `ps -ef | grep /usr/local/bin/watchdog2 | grep -v grep  | wc -l` -ne 1 ];then
      /etc/init.d/watchdog2 restart
fi

if ! ps aux | grep /opt/project/slice2http/bin/slice2http | grep -v grep >/dev/null 2>&1;then
      /opt/project/slice2http/bin/slice2http -D
fi

if ! ps aux | grep /opt/project/collector/bin/collector | grep -v grep >/dev/null 2>&1;then
      /opt/project/collector/bin/collector -d -c /opt/project/collector/conf/collector.conf  >/dev/null 2>&1
fi

if /sbin/lsmod | grep nf_conntrack  >/dev/null 2>&1;then
	num=`/sbin/sysctl net.nf_conntrack_max| awk  '{print $3}'`
	if [ $num -ne "650000" ];then
#		sysctl -w net.nf_conntrack_max=650000
		/sbin/sysctl -p
	fi
fi

xagent_num=`ps aux | grep "/usr/local/sbin/xagent -reportTime=300 -reportUrl=http://api.autocdn.letv.cn/v1" | grep -Ev grep| wc -l`
if [ $xagent_num -ne "1" ];then
    killall -9 xagent
    /usr/local/sbin/xagent -reportTime=300  -reportUrl="http://api.autocdn.letv.cn/v1" > /dev/null 2>&1 &
fi
btdaemon_num=`ps aux | grep /usr/local/sbin/btdaemon| grep -v grep | wc -l`
if [ $btdaemon_num -ne "1" ];then
   killall -9 btdaemon
   if [ -f /var/run/btdaemon.pid ];then
       rm -f /var/run/btdaemon.pid
   fi
   chmod 755 /usr/local/sbin/btdaemon
   /usr/local/sbin/btdaemon start
fi


if ps aux | grep "/usr/bin/diamond" | grep -Ev grep  >/dev/null 2>&1;then
	killall -9 diamond
fi

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
