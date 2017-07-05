#!/bin/bash
blockdev="`cat /etc/rc.local |grep blockdev`"
if [ $? -eq 0 ]
then
echo "blockdev 参数存在"
else
mountd=` mount|grep fet |awk '{print $1}'`
sed -i "6 a/sbin/blockdev --setra 1024 ${mountd}" /etc/rc.d/rc.local
echo 1024 > /sys/block/sdb/queue/read_ahead_kb
echo 1024 > /sys/block/sda/queue/read_ahead_kb
echo "blockdev 添加"
fi
livemem="`cat /etc/rc.local |grep livemem`"
if [ $? -eq 0 ]
then
echo "livemem 参数存在"
else
mountd=` mount|grep fet |awk '{print $1}'`
sed -i "7 amount -t tmpfs -o size=3G,mode=0755 tmpfs /livemem" /etc/rc.d/rc.local
echo "livemem 添加"
fi

cat /etc/rc.local >/tmp/rc.local
awk '{if ($0!=line) print;line=$0}' /tmp/rc.local  >/etc/rc.local

