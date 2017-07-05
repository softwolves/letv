#!/bin/bash

if [ `ps -ef |grep rsyslog_agent.sh|grep -vc grep` -gt 3 ]
then
	exit
else
cd /usr/local/zabbix
NUM1=`tail -n1 /etc/rsyslog.conf|grep -c 8125`
NUM2=`tail -n1 /etc/rsyslog.conf|grep 5549|grep -c @@`
if [ $NUM1 -eq 0 ] && [ -s /etc/rsyslog.conf ] && [ $NUM2 -eq 0 ]
  then
cp /etc/rsyslog.conf /etc/rsyslog_old.conf

cat << EOF >> /etc/rsyslog.conf
*.info;mail.none;authpriv.none;cron.none  @115.182.51.130:8120
authpriv.*                                @115.182.51.130:8121
mail.*					  @115.182.51.130:8122
cron.*                                    @115.182.51.130:8123
uucp,news.crit                            @115.182.51.130:8124
local7.* 				  @115.182.51.130:8125
EOF
cat /dev/null > /tmp/rsyslog_md5sum.tmp
fi
  if [ $NUM2 -eq 1 ] && [ -s /etc/rsyslog.conf ]
     then
cp /etc/rsyslog.conf /etc/rsyslog_old.conf
sed /'^*.info;mail.none;authpriv.none;cron.none.*@@'/d -i /etc/rsyslog.conf
sed /'^authpriv.*@@'/d -i /etc/rsyslog.conf
sed /'^mail.*@@'/d -i /etc/rsyslog.conf
sed /'^cron.*@@'/d -i /etc/rsyslog.conf
sed /'^uucp,news.crit.*@@'/d -i /etc/rsyslog.conf
sed /'^local7.*@@'/d -i /etc/rsyslog.conf
cat << EOF >> /etc/rsyslog.conf
*.info;mail.none;authpriv.none;cron.none  @115.182.51.130:8120
authpriv.*                                @115.182.51.130:8121
mail.*                                    @115.182.51.130:8122
cron.*                                    @115.182.51.130:8123
uucp,news.crit                            @115.182.51.130:8124
local7.*                                  @115.182.51.130:8125
EOF
cat /dev/null > /tmp/rsyslog_md5sum.tmp
fi

NUM_IP=`cat /usr/local/zabbix/conf/host.temp|wc -w`
if [ $NUM_IP -eq 3 ]
  then
     PROXY_IP=`cat /usr/local/zabbix/conf/host.temp|awk '{print $2}'`
     PROXY=`tail -n 1 /etc/rsyslog.conf |awk -F @ '{print $2}' |awk -F : '{print $1}'`
  if [[ $PROXY_IP != $PROXY ]] && [[ $PROXY_IP != "" ]] && [[ $PROXY != "" ]]
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
     if [ "$md5sum1" == "$md5sum2" -a $defunct_pro -eq 0 ]
     then
 	exit
     else
        /etc/init.d/rsyslog restart
        echo $md5sum1  > /tmp/rsyslog_md5sum.tmp
     fi
fi
fi
