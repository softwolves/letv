#!/bin/bash

if [ ! -d "/home/nginxlog" ];then
	mkdir -p /home/nginxlog
fi
###查看是否有ON这个文件，如果有才会执行以下脚本
if [ -f "/home/nginxlog/ON" ];then

filename="/usr/local/letv/access.log"
#filename="/tmp/access.log"
time_new=`tail -1 ${filename} | awk '{print $3}'| awk -F'/' '{print $NF}'`
time_old=`echo "$time_new"|awk -F':' '{printf("%s:%s:%s:%s",$1,$2,$3-5,$4)}'`
#echo $time_new
#echo $time_old
#sed -n '/'$time_old'/,/'$time_new'/p' $filename > /home/nginxlog/nginx_tmp
tail -50000 $filename  > /home/nginxlog/nginx_tmp
#log_num=`cat /home/nginxlog/nginx_tmp | wc -l`
grep -E "m3u8\?" /home/nginxlog/nginx_tmp | grep -E "MISS"| grep -E "owninneragent" | awk '{if ($10 >1)print}'>/home/nginxlog/m3u8log
grep -E "ts\?" /home/nginxlog/nginx_tmp | grep -E "MISS"| grep -E "owninneragent" | awk '{if ($10 >2)print}'>/home/nginxlog/tslog
num_m3u8=`cat /home/nginxlog/m3u8log | wc -l`
num_ts=`cat /home/nginxlog/tslog |wc -l`
if [ "$num_m3u8" != 0 ];then
	num_m3u8_504=`cat /home/nginxlog/m3u8log|awk -F'"*"' '{print $2,$3}'|awk '{if($(NF-2)~/504/)print $0}'| wc -l`

	num_m3u8_502=`cat /home/nginxlog/m3u8log|awk -F'"*"' '{print $2,$3}'|awk '{if($(NF-2)~/502/)print $0}'| wc -l`
else
	num_m3u8_504="0"
	num_m3u8_502="0"
fi

if [ "$num_ts" != "0" ];then
	num_ts_504=`cat /home/nginxlog/tslog|awk -F'"*"' '{print $2,$3}'|awk '{if($(NF-2)~/504/)print $0}'| wc -l`

	num_ts_502=`cat /home/nginxlog/tslog|awk -F'"*"' '{print $2,$3}'|awk '{if($(NF-2)~/502/)print $0}'| wc -l`
else
	num_ts_504="0"
	num_ts_502="0"
fi
touch /home/nginxlog/result
echo "m3u8-timeout  ${num_m3u8}  `echo "scale=2;r=${num_m3u8}/500;if(length(r) == scale(r)) print 0;print r"|bc`">/home/nginxlog/result
echo "m3u8-504  $num_m3u8_504  `echo "scale=2;r=${num_m3u8_504}/500;if(length(r) == scale(r)) print 0;print r"|bc`">>/home/nginxlog/result
echo "m3u8-502  $num_m3u8_502  `echo "scale=2;r=${num_m3u8_502}/500;if(length(r) == scale(r)) print 0;print r"|bc`">>/home/nginxlog/result
echo "ts-timeout  ${num_ts}  `echo "scale=2;r=${num_ts}/500;if(length(r) == scale(r)) print 0;print r"|bc`">>/home/nginxlog/result
echo  "ts-504 ${num_ts_504} `echo "scale=2;r=${num_ts_504}/500;if(length(r) == scale(r)) print 0;print r"|bc`">>/home/nginxlog/result
echo  "ts-502 ${num_ts_502} `echo "scale=2;r=${num_ts_502}/500;if(length(r) == scale(r)) print 0;print r"|bc`">>/home/nginxlog/result

fi
