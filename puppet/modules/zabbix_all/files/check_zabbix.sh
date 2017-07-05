#!/bin/bash
cd /usr/local/zabbix
if [ -s /usr/local/zabbix/zabbix_update.tar.gz -a -s /usr/local/zabbix/md5sum_update.tmp ]
  then
     md5sum_update1=`md5sum /usr/local/zabbix/zabbix_update.tar.gz|awk '{print $1}'`
     md5sum_update2=`cat /usr/local/zabbix/md5sum_update.tmp`
     if [ $md5sum_update1 != $md5sum_update2 ]
        then
        tar xfz /usr/local/zabbix/zabbix_update.tar.gz
        echo $md5sum_update1  > /usr/local/zabbix/md5sum_update.tmp
     fi
  else
     echo "0" > /usr/local/zabbix/md5sum_update.tmp
  fi

NUM_IP=`cat /usr/local/zabbix/conf/host.temp|wc -w`
if [ $NUM_IP -eq 3 ]
  then
     HOSTNAME=`cat /usr/local/zabbix/conf/host.temp|awk '{print $1}'`
     PROXY_IP=`cat /usr/local/zabbix/conf/host.temp|awk '{print $2}'`
     PROXY_LIST=`cat /usr/local/zabbix/conf/host.temp|awk '{print $3}'`
     HOST=`cat /usr/local/zabbix/conf/zabbix_agentd.conf|grep "^Hostname="|awk -F"=" '{print $2}'`
     PROXY=`cat /usr/local/zabbix/conf/zabbix_agentd.conf|grep "^ServerActive="|awk -F"=" '{print $2}'`
     LIST=`cat /usr/local/zabbix/conf/zabbix_agentd.conf|grep "^Server="|awk -F"=" '{print $2}'`
     LIST1="115.182.51.13,115.182.51.14,115.182.93.64,115.182.93.59,115.182.93.58,10.200.93.59,10.200.93.64,10.200.93.58,127.0.0.1,117.121.54.22,10.100.54.22,117.121.54.43,10.100.54.43,115.182.93.142,10.200.93.142,115.182.63.80,10.182.63.80,10.150.140.25,115.182.93.137,10.200.93.137,10.0.51.13,115.182.93.160,10.200.93.160,117.121.54.157,10.100.54.157,115.182.63.72,10.182.63.72,10.150.130.29,117.121.54.54,10.100.54.54,115.182.51.26,10.182.51.26,211.144.19.33,211.144.19.34"
  if [[ $HOSTNAME != $HOST ]] || [[ $PROXY_IP != $PROXY ]] || [[ "${LIST1},$PROXY_LIST" != $LIST ]]
     then
       killall zabbix_agentd
       sleep 5
       kill -9 `ps -ef|grep /usr/local/zabbix/sbin/zabbix_agentd|grep -v grep|awk '{print $2}'`
  fi
  if [[ $HOSTNAME != $HOST ]]
     then
       sed "s#Hostname=$HOST#Hostname=$HOSTNAME#" /usr/local/zabbix/conf/zabbix_agentd.conf > /usr/local/zabbix/conf/zabbix_agentd.conf.bak
       mv -f /usr/local/zabbix/conf/zabbix_agentd.conf.bak /usr/local/zabbix/conf/zabbix_agentd.conf
  fi
  if [[ $PROXY_IP != $PROXY ]]
     then
       sed "s#ServerActive=$PROXY#ServerActive=$PROXY_IP#" /usr/local/zabbix/conf/zabbix_agentd.conf > /usr/local/zabbix/conf/zabbix_agentd.conf.bak
       mv -f /usr/local/zabbix/conf/zabbix_agentd.conf.bak /usr/local/zabbix/conf/zabbix_agentd.conf
  fi
  if [[ "${LIST1},$PROXY_LIST" != $LIST ]]
     then
       sed "s#Server=$LIST#Server=$LIST1,$PROXY_LIST#" /usr/local/zabbix/conf/zabbix_agentd.conf > /usr/local/zabbix/conf/zabbix_agentd.conf.bak
       mv -f /usr/local/zabbix/conf/zabbix_agentd.conf.bak /usr/local/zabbix/conf/zabbix_agentd.conf
  fi
fi

ps -ef|grep zabbix_agentd|grep -v grep > /dev/null
if [ $? -eq 1 ]
  then 
  /usr/local/zabbix/sbin/zabbix_agentd -c /usr/local/zabbix/conf/zabbix_agentd.conf start
  else
     md5sum1=`md5sum /usr/local/zabbix/conf/zabbix_agentd.userparams.conf|awk '{print $1}'`
     md5sum2=`cat /usr/local/zabbix/md5sum.tmp`
     defunct_pro=`ps -ef|grep zabbix_agentd | grep defunct | grep -v grep |wc -l`
     if [ $md5sum1 == $md5sum2 -a $defunct_pro -eq 0 ]
     then
 	exit
     else
        killall zabbix_agentd
	sleep 5
	kill -9 `ps -ef|grep /usr/local/zabbix/sbin/zabbix_agentd|grep -v grep|awk '{print $2}'`
        /usr/local/zabbix/sbin/zabbix_agentd -c /usr/local/zabbix/conf/zabbix_agentd.conf start
        echo $md5sum1  > /usr/local/zabbix/md5sum.tmp
     fi
fi
