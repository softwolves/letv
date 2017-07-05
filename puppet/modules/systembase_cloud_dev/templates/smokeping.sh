#!/bin/bash
PATH=/usr/kerberos/sbin:/usr/kerberos/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin

#grep -xq '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' /data/smokeping/localip 
grep -xq "^#smokeip:[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}" /usr/local/etc/hosts.conf
if [ $? -eq 0 ]
then
	hname=`grep -Ei "^#smokeip" /usr/local/etc/hosts.conf| awk -F':' '{print $2}'` 
else
	hname=`ifconfig | sed -n '/inet[[:space:]]/p' | awk 'BEGIN{n=1;m=1}{if($2 ~ /addr:/){split($2,pip,":");ip[n++]=pip[2]}else{ip[n++]=$2}}END{for (i=1;i<=n;i++){if(ip[i] !~ /^(192|169|172|127|10)\./) oip[m++]=ip[i]};if(m >3){print oip[2]}else{print oip[1]}}'`
fi

cd /data/smokeping/
perl /data/smokeping/bin/smokeping.dist --master-url=http://smokehttp.oss.letv.com/smokeping/smokeping.cgi --cache-dir=/data/smokeping/ --shared-secret=/data/smokeping/etc/smokeping_secrets --slave-name=$hname

#perl /data/smokeping/bin/smokeping.dist --master-url=http://smokeping.oss.letv.com/smokeping/smokeping.cgi --cache-dir=/tmp/ --shared-secret=/data/smokeping/etc/smokeping_secrets --slave-name=$hname
