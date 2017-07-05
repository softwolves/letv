#/bin/bash
#by duhaibin@letv.com
#2014年 03月 31日 星期一 10:50:28 CST
#测试同运营商是否丢包以及下载速度
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
#根据主机名字选择下载测试列表
host=`hostname`
local_date="`date +%m%d%H`"
local_path="/letv/fet/dataspeed/"
list_path="/letv/soft/tools/"
filename_data="curl${local_date}.csv"
if echo "$host"|grep -Ei "cdn"|grep -Eqi "cnc";then
	list_com="cnc_list"
elif echo "$host"|grep -Ei "cdn" |grep -Eqi "ctc";then
	list_com="ctc_list"
else
	list_com="list"
fi


#创建目录
if [ ! -d /letv/fet/dataspeed ];then
mkdir -p /letv/fet/dataspeed
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
	ip=`echo "$line" | awk '{print $1}'`
	filename=`echo "$line" | awk '{print $2}'`
	filesize=`echo "$line" | awk '{print $3}'`
	if [ -z $filename ];then
		filename="down"
	fi
	if [ -z $filesize ];then
		filesize="1M"
	fi	

	if [ ! -f /letv/fet/downfile/${filename}${filesize} ];then
		dd if=/dev/zero of=/letv/fet/downfile/${filename}${filesize} count=1 bs=${filesize}
	fi

	runtime=`date '+%Y-%m-%d %H:%M'`
        pkg_loss="`ping -c 200 -i0.01  -nq $ip |grep packet |awk '{print $6}'|sed 's/%//g'`"
        ping_min="`ping -c 200 -i0.01  -nq $ip |grep rtt |awk '{print $4}' |awk -F/ '{print $1}'`"
        ping_avg="`ping -c 200 -i0.01  -nq $ip |grep rtt |awk '{print $4}' |awk -F/ '{print $2}'`"
        ping_max="`ping -c 200 -i0.01  -nq $ip |grep rtt |awk '{print $4}' |awk -F/ '{print $3}'`"
###########下载磁盘文件
        datacurl_disk=`curl -q -o /dev/null -m 20 -s  --connect-timeout 10 -A "down-speed-test-by-duhaibin" -w %{http_code},%{time_namelookup},%{time_connect},%{time_pretransfer},%{time_starttransfer},%{time_total},%{size_download},%{speed_download} "http://${ip}/downfile/${filename}${filesize}"` 
##########下载内存文件
	datacurl_mem=`curl -q -o /dev/null -m 20 -s  --connect-timeout 10 -A "down-speed-test-by-duhaibin" -w %{http_code},%{time_namelookup},%{time_connect},%{time_pretransfer},%{time_starttransfer},%{time_total},%{size_download},%{speed_download} "http://${ip}/letvabcdeasktf${filesize}"`
#########从磁盘下载tag 标记为10
	data_output_disk="${runtime},$ip,${pkg_loss},${ping_min},${ping_avg},${ping_max},${datacurl_disk},10"
#########从内存下载tag标记为20
	data_output_mem="${runtime},$ip,${pkg_loss},${ping_min},${ping_avg},${ping_max},${datacurl_mem},20"
	echo $data_output_disk >> ${local_path}${filename_data}
	echo $data_output_mem  >> ${local_path}${filename_data}
	sleep 2 
	echo >&6
	}&
	
done
wait
exec 6>&-
