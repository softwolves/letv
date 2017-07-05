#!/bin/bash
#power by duhaibin
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
export PATH
export LANG="en_CN.UTF-8"
#根据主机名字选择下载测试列表
shellpath="/letv/soft/tools/xsmoke/"
logpath="/letv/fet/downfile/smokepinglog"

if [ ! -f $logpath ];then
mkdir -p  $logpath

fi
if [ ! -f $shellpath ];then
mkdir -p  $shellpath
fi

time_z=`date +%H`
time_a=`date +%Y%m%d%H%M`
time_d=`date --date "4 hours ago" +"%H"`

S_ip=`grep -Ei  '#smokeip' /usr/local/etc/hosts.conf | awk -F':' '{print $2}'`
S_nodename=`grep -E "$S_ip" ${shellpath}list|awk '{print $1}'`

if [ ! -z $S_nodename ];then

#新建filo类型文件，并将fd6指向fifo类型
tmp_fifofile="/tmp/$$.fifo"
mkfifo $tmp_fifofile
exec 6<>$tmp_fifofile
rm $tmp_fifofile
#定义并发的进程个数
thread=30
#再fd6中放置thread个回车
for ((j=0;j<$thread;j++));do
echo
done >&6

cat ${shellpath}list | grep -Ev "^#"|while read line

do
	
        read -u6
        {

		ip=`echo $line| awk '{print $2}'`
		T_nodename=`echo $line| awk '{print $1}'`	
		pkg_loss=`/bin/ping -c 10 -i0.01  -nq $ip |grep packet |sed 's/,/\n/g'| grep 'loss' | awk  '{print $1}'|sed 's/%//g'`
		if [ $pkg_loss == 100 ];then
		timedown="99000"
		else
		datacurl_mem=`curl -o /dev/null -m 10 -s  --connect-timeout 2 -A "down-speed-test-by-duhaibin" -w %{time_total} "http://${ip}/letvabcdeasktf1024k"`
			if [ "$datacurl_mem" == "0.000"  ];then
				timedown="99000"
			else
				timedown=`echo "scale=4;r=${datacurl_mem}*1000;if(length(r) == scale(r)) print 0;print r"|bc`
			fi
		fi
		echo "$time_z,$S_nodename,$T_nodename,$timedown,$pkg_loss,$time_a" >>${logpath}/${time_z}
#		echo "$time_z,$S_nodename,$T_nodename,$timedown,$pkg_loss,$time_a" 

        echo >&6
        }&

done

wait
#exit 0
exec 6>&-

rm -f ${logpath}/$time_d

fi
