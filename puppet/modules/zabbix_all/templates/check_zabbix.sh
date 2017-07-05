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
     LIST1="127.0.0.1,10.98.28.11,10.100.54.22,10.100.54.43,10.150.130.29,103.7.5.191,107.155.56.170,107.155.57.121,115.182.51.14,115.182.63.182,115.182.93.142,115.182.93.59,115.182.93.64,117.121.54.22,117.121.54.43,118.26.58.29,118.26.58.30,119.97.158.167,123.125.91.25,125.91.9.98,211.162.52.2,65.255.32.74,10.120.48.54,10.120.148.13,10.120.128.16,10.182.51.14,10.182.63.182,10.200.93.142,10.200.93.59,10.200.93.64,10.100.54.43,10.140.120.114,10.140.120.115,10.150.140.25,10.120.8.63,101.69.206.130,103.7.6.183,106.38.180.123,107.155.42.30,107.155.56.122,107.155.57.123,112.25.27.117,114.80.187.245,114.80.187.240,115.182.51.13,115.182.63.180,115.182.92.90,115.182.92.91,115.182.93.118,117.121.54.102,117.121.54.103,119.97.158.129,124.232.157.180,125.91.9.96,180.96.68.180,211.162.59.93,218.206.201.236,221.181.203.128,111.7.164.130,124.232.157.207,10.120.48.138,10.150.130.100,10.120.8.3,10.120.148.30,10.120.128.34,10.0.51.13,10.182.63.180,10.200.92.90,10.200.92.91,10.200.93.118,10.100.54.102,10.100.54.103,10.140.90.150,10.140.90.151,124.232.157.170,10.11.144.255,10.11.145.0,10.135.30.112,10.176.30.218,10.182.192.215,10.204.29.239,115.182.93.105,10.200.93.105,115.182.93.175,10.200.93.175,115.182.92.60,10.200.92.60,115.182.92.61,10.200.92.61,10.200.84.58,10.104.29.50,115.182.200.99,10.154.33.253,115.182.200.100,10.154.33.252,124.165.206.28,115.182.200.97,115.182.200.98,10.154.34.1,10.154.33.255,114.80.187.240,119.147.182.212,10.120.57.142,10.120.57.141,115.182.51.83,10.182.200.152,115.182.51.85,10.182.200.154,103.7.4.111,10.120.57.142,103.7.4.253,10.120.57.141,107.155.53.95,10.120.9.253,202.47.215.123,10.121.152.14,211.144.19.33,211.144.19.34,123.59.126.229,123.59.126.232"
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
