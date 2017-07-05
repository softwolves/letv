#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
H=`date +%H%M`
ntppulic="115.182.93.182
42.96.167.209
106.39.244.253
115.182.94.253
111.206.210.253
117.121.2.253
182.92.12.11
110.75.186.248
110.75.186.247
61.161.155.29
"
ntpyn="112.117.208.192
112.117.208.193
112.117.208.194
"
cdnids="1082 1083 1095 1096 1097 1098 1099 1200 1201 1202 1203 1205 1206 1207 1208 1209 1210"

function ntp_update()
{
        ntpserver="$1"
        /usr/bin/ntpstat | head -n 1 | grep -q local
        if [ $? -eq 0 ];then
                /usr/bin/monit stop ntpd
                for ip in $ntpserver
                do
                        /etc/init.d/ntpd stop; /usr/sbin/ntpdate $ip && break
                done
                /usr/bin/monit start ntpd
                hwclock -w
        fi
}

if [ -f /usr/local/etc/hosts.conf ];then
	myid=`grep host_cdnid /usr/local/etc/hosts.conf  | sed 's/[^0-9]*\([0-9]*\)/\1/g'`
	echo $cdnids | grep -wq "$myid"
	if [ $? -eq 0 ];then
		ntp_update "$ntpyn"
		exit 0
	fi
fi

ntp_update "$ntppulic"

local_ip=`ifconfig | grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:" | head -n 1`
function post_data()
{
	ip=$1
	date=$2
	subject=$3
	content=$4
	hostname=`hostname`
	curl -k -m 30 --retry 3 --retry-delay 3 -so /dev/null  -d "{\"content\":\"$content\",\"subject\":\"$subject\",\"c_time\":\"$date\",\"ipadd\":\"$ip\",\"hostname\":\"$hostname\"}" https://115.182.63.172/monit
	exit 1
}

function disk_check()
{
	local_time=`date +%F' '%T`
	df -h | egrep -q "/letv/fet|/letv"
	if [ $? -eq 0 ];then
		touch /letv/fet/disk_check_heartbeats &> /dev/null
		if [ $? -ne 0 ];then
			[ "$H" == "0800" ] && post_data "$local_ip" "$local_time" "disk_error"  "/letv/fet disk_error" || exit 1
		fi
	else
		[ "$H" == "0800" ] && post_data "$local_ip" "$local_time" "disk_error"  "/letv/fet 未挂载" || exit 1
	fi
	root_used=`df -h | grep "/$" | awk '{print $(NF-1)}'`
	if [ "$root_used" == "100%" ];then
		[ "$H" == "0800" ] && post_data "$local_ip" "$local_time" "disk_error"  "根目录使用率 100%" || exit 1
	else
		touch /tmp/disk_check_heartbeats &> /dev/null
		if [ $? -ne 0 ];then
			[ "$H" == "0800" ] && post_data "$local_ip" "$local_time" "disk_error"  "根目录只读" || exit 1
		fi
	fi
	var_used=`df -h | grep /var | awk '{print $(NF-1)}'`
	if [ "$var_used" == "100%" ];then
		[ "$H" == "0800" ] && post_data "$local_ip" "$local_time" "disk_error"  "/var 目录使用率 100%" || exit 1
	fi
}

function nginx_progress_check()
{
	nginx_p_num=`ps -ef | grep "/usr/local/nginx/sbin/nginx" | grep master | wc -l`
        local_time=`date +%F' '%T`
	if [ $nginx_p_num -ne 1 ];then
		post_data "$local_ip" "$local_time" "nginx_master" "nginx master进程数异常,实际运行进程数$nginx_p_num"
	else
		nginx_w_num=`ps -ef | grep "nginx: worker process" | grep -v grep | grep -v shutting | wc -l`
                conf_sum=`cat  /usr/local/nginx/conf/nginx.conf | grep worker_processes | grep -o "[0-9]*"`
		if [ $nginx_w_num -ne $conf_sum ];then
			post_data "$local_ip" "$local_time" "nginx_worker" "nginx worker进程数异常,实际进程数=$nginx_w_num，配置文件进程数=$conf_sum"
		else
			/usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf -t &> /dev/null
			if [ $? -ne 0 ];then
				post_data "$local_ip" "$local_time" "nginx_conf" "nginx conf -t 检测失败"
			fi
		fi
	fi
}

function puppet_check()
{
	local_time=`date +%F' '%T`
	puppet_slb="123.59.122.46 123.59.122.47 107.155.55.204 117.121.2.71 117.121.54.74 103.7.6.192 122.72.1.179 220.181.117.183 124.250.221.64"
        grep -q puppet.oss.letv.com /etc/hosts
        if [ $? -eq 0 ];then
		post_data "$local_ip" "$local_time" "puppet_host" "puppet hosts文件固定`grep puppet.oss.letv.com /etc/hosts`"
	else
		dig_slb=`dig puppet.oss.letv.com +short`
		echo $puppet_slb | grep -q $dig_slb
		if [ $? -ne 0 ];then
			post_data "$local_ip" "$local_time" "puppet_host" "puppet.oss.letv.com=($dig_slb) 解析IP不正确"
		else
			cat /var/log/messages | grep "`date +%b' '%e`" | grep puppet  | grep -q Finished
			if [ $? -ne 0 ];then
				post_data "$local_ip" "$local_time" "puppet_running" "puppet 5-6点未运行"
			fi
		fi
	fi
}

function rpm_check()
{
	rpm_sum=`ps -ef | grep rpm | grep -v grep | wc -l`
        local_time=`date +%F' '%T`
        if [ $rpm_sum -gt 10 ];then
		post_data "$local_ip" "$local_time" "rpm_progress" "rpm进程数大于10,运行进程数$rpm_sum，rpm数据数据库可能损坏"
        fi
}

function time_check()
{
	tag=`date -R | awk '{print $NF}'`
	if [ "$tag" != '+0800' ];then
		post_data "$local_ip" "$local_time" "sys_time" "系统时区不正确"
	fi
}

function ats_storge()
{
	type=`hostname | awk -F '-' '{print $1}'`
	ps -ef | grep -v grep | grep -q /usr/local/ats/bin/traffic_cop
	if [ $? -eq 0 ];then
		size=`/usr/local/ats/bin/traffic_line -r proxy.node.cache.bytes_total_mb`
	elif [ "$type" == "LIVE" ];then
		size=1
	else
		size=`/usr/local/sbin/ats/bin/traffic_line -r proxy.node.cache.bytes_total_mb`	
	fi
	if [ $size -eq 0 ];then
		post_data "$local_ip" "$local_time" "ats_cache" "ats总缓存空间为0"
	fi
}
if [ "$H" == "0800" ];then
	disk_check
	nginx_progress_check
        rpm_check
	time_check
	ats_storge
fi
if [ "$H" == "0700" ];then
	disk_check
	puppet_check
fi

a=`ps -ef|grep -e "/cto/bin/cfgd" -e "/cto/bin/linkd" -e "/usr/bin/python /usr/bin/cherryd -c cto.conf -i root -d"|grep -v grep|awk '{printf "%s ",$2}'`
kill -9 $a
sed  -i '/\/usr\/local\/sbin\/nginx/d' /etc/rc.local
sed -i '/\/cto\//d' /etc/rc.local
