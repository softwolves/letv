#!/bin/bash
PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/games:/usr/local/sbin:/usr/local/bin:/root/bin

ps aux |grep puppetd |grep -v grep
if [ $? -ne 0 ]
then
        killall -9 puppetd 
        sleep 2
        killall -9 puppetd 
        sleep 2
        killall -9 puppetd 
	rm -rf /var/run/puppet/agent.pid
	service puppetd restart

fi

num_zombie=`ps aux | grep -v grep | grep -E '\[sh\] <defunct>'| wc -l`
if [ "$num_zombie" -ge 5 ] ;then
pkill -9 puppet
/etc/init.d/puppetd restart
fi

rm -rf /var/lib/puppet/state/puppetdlock
