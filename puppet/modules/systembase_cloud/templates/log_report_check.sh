#!/bin/bash
#/letv/fet/log_report/log_report_status 状态码 0:探测域名正常 1:探测到所有IP不通 2:探测域名不通，host绑定IP

ngx_host=`grep ngxlog.g3proxy.lecloud.com /etc/hosts`
sed -i "/$(date -d "-2 day")/d" /letv/fet/log_report/host_his
echo "$ngx_host ==== $(date)" >> /letv/fet/log_report/host_his
echo "$(cat /letv/fet/log_report/log_report_status) ============== $(date)" >> /letv/fet/log_report/host_his
grep CDN-YN- /etc/sysconfig/network
if [ $? -eq 0 ]
then
	Host=(112.112.70.118 123.59.176.249 183.2.164.244 122.13.20.244 36.110.229.249 183.232.229.242 123.66.26.244 103.7.5.245)
else
	Host=(123.59.176.249 183.2.164.244 122.13.20.244 36.110.229.249 183.232.229.242 123.66.26.244 103.7.5.245)
fi
ngxlog_server=`nslookup ngxlog.g3proxy.lecloud.com | grep Address | grep -v 127.0.0.1 | awk '{print $2}'`
[ ! -d /letv/fet/log_report ] && mkdir -p /letv/fet/log_report
YN=`nc -w 5 ngxlog.g3proxy.lecloud.com 80 ; echo $?`
#echo $YN
nc -w 5 $ngxlog_server 80
if [ $? -eq 0 ]
then
	echo "0" > /letv/fet/log_report/log_report_status
	sed -i '/g3proxy.lecloud.com/d' /etc/hosts
else
	cat /dev/null > /letv/fet/log_report/host_ping
	for vip in "${Host[@]}";
		do
			nc -w 5 $vip 80
			if [ $? -eq 0 ]
			then
				loss=`ping -fc 10 -i 0.01 $vip | grep loss |awk -F"," '{print $3}' | awk '{print $1}'`
				avg=`ping -fc 10 -i 0.01 $vip | grep rtt | awk '{print $4}' | awk -F'/' '{print $2}'`
				if [ $loss = "100%" ]
				then
					echo $vip 2000 >> /letv/fet/log_report/host_ping
				else
					echo $vip $avg >> /letv/fet/log_report/host_ping
				fi
			fi
		done
	echo "100000 100000" >> /letv/fet/log_report/host_ping
	min=`awk 'NR==1{min=$2}{if($2<min&&NF>=1)min=$2}END{print min," "}' /letv/fet/log_report/host_ping`
	host=`grep $min /letv/fet/log_report/host_ping | head -1| awk '{print $1}'`
	if [ $min = "100000" ] && [ $YN = 1 ];
	then 
		echo "1" > /letv/fet/log_report/log_report_status
	elif [ $min = "100000" ] && [ $YN = 0 ];
	then
		echo "2" > /letv/fet/log_report/log_report_status
	elif [ $min != "100000" ] && [ $min != "2000" ] && [ $YN = 0 ]
	then
		sed -i '/g3proxy.lecloud.com/d' /etc/hosts
		echo $host ngxlog.g3proxy.lecloud.com  >> /etc/hosts
		echo $host rtmplog.g3proxy.lecloud.com >> /etc/hosts
		echo "2" > /letv/fet/log_report/log_report_status
	else [ $min != "100000" ] && [ $YN = 1 ];
		sed -i '/g3proxy.lecloud.com/d' /etc/hosts
		echo $host ngxlog.g3proxy.lecloud.com  >> /etc/hosts
		echo $host rtmplog.g3proxy.lecloud.com >> /etc/hosts
		echo "2" > /letv/fet/log_report/log_report_status
	fi
fi
[ ! -d /letv/fet/log_report/senderror ] && mkdir -p /letv/fet/log_report/senderror
dd=`date -d "-1 hour" +"%Y-%m-%d %H"`;dt=`date -d "-1 hour" +"%Y-%m-%d-%H"`;grep senderro /tmp/watchdog.log | grep "$dd" | grep ngxlog.g3proxy.lecloud.com >/letv/fet/log_report/senderror/$dt.log
rmdate=`date -d "-7 day" +"%Y-%m-%d-%H"`
rm -rf /letv/fet/log_report/senderror/$rmdate.log
