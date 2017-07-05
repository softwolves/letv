#!/bin/bash

if [ `ps -ef |grep rsyslog_proxy.sh|grep -vc grep` -gt 3 ]
then
	exit
else
cd /usr/local/zabbix
tail -n1 /etc/rsyslog.conf|grep 5549 > /dev/null
if [ $? -eq 1 ] && [ -s /etc/rsyslog.conf ]
  then
cp /etc/rsyslog.conf /etc/rsyslog_old.conf

cat << EOF >> /etc/rsyslog.conf
*.info;mail.none;authpriv.none;cron.none  @@115.182.51.130:5544
authpriv.*                                @@115.182.51.130:5545
mail.*					  @@115.182.51.130:5546
cron.*                                    @@115.182.51.130:5547
uucp,news.crit                            @@115.182.51.130:5548
local7.* 				  @@115.182.51.130:5549
EOF
 
cat /dev/null > /tmp/rsyslog_md5sum.tmp

fi 

NUM_IP=`cat /usr/local/zabbix/conf/host.temp|wc -w`
if [ $NUM_IP -eq 3 ]
  then
     PROXY_IP=`cat /usr/local/zabbix/conf/host.temp|awk '{print $2}'`
     PROXY=`tail -n 1 /etc/rsyslog.conf |awk -F @@ '{print $2}' |awk -F : '{print $1}'`
  if [[ $PROXY_IP != $PROXY ]] && [[ $PROXY_IP != "" ]]
     then
     sed -i "s/$PROXY/$PROXY_IP/g" /etc/rsyslog.conf
  fi
fi

ps -ef |grep rsyslogd|grep -v grep > /dev/null
if [ $? -eq 1 ]
  then 
     /etc/init.d/rsyslog start
  else
     md5sum1=`md5sum /etc/rsyslog.conf|awk '{print $1}'`
     md5sum2=`cat /tmp/rsyslog_md5sum.tmp`
     defunct_pro=`ps -ef|grep rsyslogd | grep defunct | grep -v grep |wc -l`
     if [ $md5sum1 == $md5sum2 -a $defunct_pro -eq 0 ]
     then
 	exit
     else
        /etc/init.d/rsyslog restart
        echo $md5sum1  > /tmp/rsyslog_md5sum.tmp
     fi
fi
fi
