#!/bin/bash
#
#
# (c) 2015 , Tianbiao Zu <zutianbian@letv.com>
#
# 该脚本每隔一段时间出发一次本地nginx访问,作为大数据部门数据分析的探针,确保数据第三方客户的日志在上报过程中不存在丢失现象

##############################################################################
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
export PATH

# 本地ip地址
ip_addr=`ifconfig|grep "inet addr"|awk -F ':' '{print $2}'|awk '{print $1}'|head -n 1`

for((i=1;i<=6;i++))
do
curl -so /dev/null "http://$ip_addr/crossdomain.xml?cuid=100&platid=2&splatid=206&tag=dmptest"
sleep 10
done
