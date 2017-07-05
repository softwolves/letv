#!/bin/bash
#Power by duhaibin@letv.com
#2015年 04月 29日 星期四 14:42:40 CST
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
lockfile='/var/run/update_stresstest.pid'
# single instance
if test -f $lockfile;then
    oldpid=`cat $lockfile|head -1`
    if [ `ps -p $oldpid -o comm= | wc -l` -eq 1 ];then
        echo "Error: already running. [${oldpid}]"
        exit 0
    fi
else
    echo $$ > $lockfile
fi

trap "rm -fv $lockfile;exit 0;" 0 3 15


stresstest_md5="`cat /letv/soft/nginx/md5-stresstest`"

if [ ! -d /home/lihongfu/update ]
then
        mkdir -p /home/lihongfu/update/
fi

download_addr="test.coop.gslb.letv.com"
download_bak="115.182.94.72"

filename="stress_test.tar.gz_${stresstest_md5}"
        rm -rf /home/lihongfu/update/stress_test.tar.gz
if wget -t 2 -T 30 -c -N -q -O /home/lihongfu/update/stress_test.tar.gz http://$download_addr/update/${filename} ;then
	tar xzvf /home/lihongfu/update/stress_test.tar.gz -C "/letv/soft/tools/stresstest/"
        kill -9 $(ps aux | grep vplayer | grep -v grep | awk '{print $2}')
	kill -9 $(ps aux | grep stress_testing.py | grep -v grep | awk  '{print $2}')
	wait
	cd /letv/soft/tools/stresstest/stress_test/py/;python stress_testing.py &
else
        rm -rf /home/lihongfu/update/stress_test.tar.gz
	 wget -t 2 -T 30 -c -N -q -O /home/lihongfu/update/stress_test.tar.gz http://$download_bak/update/${filename}
        tar xzvf /home/lihongfu/update/stress_test.tar.gz -C "/letv/soft/tools/stresstest/"
        kill -9 $(ps aux | grep vplayer | grep -v grep | awk '{print $2}')
        kill -9 $(ps aux | grep stress_testing.py | grep -v grep | awk  '{print $2}')
	wait
        cd /letv/soft/tools/stresstest/stress_test/py/;python stress_testing.py &

fi
md5sum /home/lihongfu/update/stress_test.tar.gz 2>&1|awk '{print $1}' >/letv/soft/nginx/md5-stresstest
