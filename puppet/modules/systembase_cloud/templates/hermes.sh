#/bin/bash
#by duhaibin@letv.com
#2014年 12月 04日 星期四 10:50:28 CST
#测试同运营商是否丢包以及下载速度
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
export PATH
export LANG="en_CN.UTF-8"
#根据主机名字选择下载测试列表
host=`hostname`
ip_s=`ifconfig | grep -Ei 'inet addr' | grep -Ev '127.0.0.1' | head -1 | awk '{print $2}' | awk -F':' '{print $2}'`
local_date="`date +%m%d%H`"
#local_path="/tmp/"
local_path="/letv/fet/downfile/dataspeed/"
list_path="/letv/soft/tools/hermes/"
#list_path="/home/"
filename_data="curl${local_date}.csv"
if echo "$host"|grep -Ei "cdn"|grep -Eqi "cnc";then
	list_com="cnc_list"
elif echo "$host"|grep -Ei "cdn" |grep -Eqi "ctc";then
	list_com="ctc_list"
else
	list_com="list"
fi


#创建目录
if [ ! -d $list_path ];then
mkdir -p $list_path
fi
if [ ! -d /letv/fet/downfile/dataspeed ];then
mkdir -p /letv/fet/downfile/dataspeed
fi
if [ ! -d /letv/fet/downfile ];then
mkdir -p  /letv/fet/downfile
fi
if [ ! -f /letv/fet/downfile/down1M ];then
dd if=/dev/zero of=/letv/fet/downfile/down1M count=1 bs=1M
fi

#新建filo类型文件，并将fd6指向fifo类型
tmp_fifofile="/tmp/$$.fifo"
mkfifo $tmp_fifofile
exec 6<>$tmp_fifofile
rm $tmp_fifofile
#定义并发的进程个数
thread=10
#再fd6中放置thread个回车
for ((j=0;j<$thread;j++));do
echo
done >&6

cat ${list_path}${list_com} | grep -Ev "^#"|while read line
do
	read -u6
	{
	ipzone=`echo "$line" | awk '{print $1}'`
	ip=`echo "$line" | awk '{print $2}'`
	filename=`echo "$line" | awk '{print $3}'`
	filesize=`echo "$line" | awk '{print $4}'`
	if [ -z $filename ];then
		filename="down"
	fi
	if [ -z $filesize ];then
		filesize="1M"
	fi	

	if [ ! -f /letv/fet/downfile/${filename}${filesize} ];then
		dd if=/dev/zero of=/letv/fet/downfile/${filename}${filesize} count=1 bs=${filesize}
	fi
        runtime=`date '+%d/%b/%Y:%H:%M:%S %z'`
        pkg_loss="`ping -c 200 -i0.01  -nq $ip |grep packet |awk '{print $6}'|sed 's/%//g'`"
        ping_min="`ping -c 200 -i0.01  -nq $ip |grep rtt |awk '{print $4}' |awk -F/ '{print $1}'`"
        ping_avg="`ping -c 200 -i0.01  -nq $ip |grep rtt |awk '{print $4}' |awk -F/ '{print $2}'`"
        ping_max="`ping -c 200 -i0.01  -nq $ip |grep rtt |awk '{print $4}' |awk -F/ '{print $3}'`"
###########下载磁盘文件
        datacurl_disk=`curl -o /dev/null -m 20 -s  --connect-timeout 10 -A "down-speed-test-by-duhaibin" -w %{http_code},%{time_namelookup},%{time_connect},%{time_pretransfer},%{time_starttransfer},%{time_total},%{size_download},%{speed_download} "http://${ip}/downfile/${filename}${filesize}"` 
##########下载内存文件
	datacurl_mem=`curl -o /dev/null -m 20 -s  --connect-timeout 10 -A "down-speed-test-by-duhaibin" -w %{http_code},%{time_namelookup},%{time_connect},%{time_pretransfer},%{time_starttransfer},%{time_total},%{size_download},%{speed_download} "http://${ip}/letvabcdeasktf${filesize}"`
#########从磁盘下载tag 标记为10
	data_output_disk="${runtime},${host},${ip_s},${ipzone},$ip,${pkg_loss},${ping_min},${ping_avg},${ping_max},${datacurl_disk},10"
#########从内存下载tag标记为20
	data_output_mem="${runtime},${host},${ip_s},${ipzone},$ip,${pkg_loss},${ping_min},${ping_avg},${ping_max},${datacurl_mem},20"
	echo $data_output_disk >> ${local_path}${filename_data}
	echo $data_output_mem  >> ${local_path}${filename_data}
	sleep 2 
	echo >&6
	}&
	
done
wait

if [ -f ${list_path}url_list ];then

cat ${list_path}url_list | grep -Ev "^#"|while read line
do
        read -u6
        {
	url_ipzone=`echo "$line" | awk '{print $1}'`
	url_ip=`echo "$line" | awk '{print $2}'`
	url=`echo "$line" | awk '{print $3}'`
        runtime=`date '+%d/%b/%Y:%H:%M:%S %z'`
        pkg_loss="`ping -c 200 -i0.01  -nq $url_ip |grep packet |awk '{print $6}'|sed 's/%//g'`"
        ping_min="`ping -c 200 -i0.01  -nq $url_ip |grep rtt |awk '{print $4}' |awk -F/ '{print $1}'`"
        ping_avg="`ping -c 200 -i0.01  -nq $url_ip |grep rtt |awk '{print $4}' |awk -F/ '{print $2}'`"
        ping_max="`ping -c 200 -i0.01  -nq $url_ip |grep rtt |awk '{print $4}' |awk -F/ '{print $3}'`"
############下载url
        datacurl_url=`curl -o /dev/null -m 20 -s  --connect-timeout 10 -A "down-speed-test-by-duhaibin" -w %{http_code},%{time_namelookup},%{time_connect},%{time_pretransfer},%{time_starttransfer},%{time_total},%{size_download},%{speed_download} "http://${url_ip}${url}"`
#########从url_list下载tag 标记为30
        data_output_url="${runtime},${host},${ip_s},${url_ipzone},${url_ip},${pkg_loss},${ping_min},${ping_avg},${ping_max},${datacurl_url},30"
        echo $data_output_url >> ${local_path}${filename_data}

	echo >&6
	}&

done
wait
fi


exec 6>&-
