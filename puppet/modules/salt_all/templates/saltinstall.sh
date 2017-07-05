#!/bin/bash
#Power by duhaibin@letv.com
#2015年 05月 22日 星期四 14:42:40 CST
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
lockfile='/var/run/install_salt.pid'
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


salt_md5="`cat /letv/soft/nginx/md5-salt`"

if [ ! -d /home/lihongfu/update ]
then
        mkdir -p /home/lihongfu/update/
fi

download_addr="test.coop.gslb.letv.com"
download_bak="115.182.94.72"

filename="salt.tar.gz_${salt_md5}"
        rm -rf /home/lihongfu/update/salt.tar.gz
if wget -t 2 -T 30 -c -N -q -O /home/lihongfu/update/salt.tar.gz http://$download_addr/update/${filename} ;then
	tar xzvf /home/lihongfu/update/salt.tar.gz -C "/tmp/"
        rpm -ivh /tmp/saltminion/*.rpm

else
        rm -rf /home/lihongfu/update/salt.tar.gz
	 wget -t 2 -T 30 -c -N -q -O /home/lihongfu/update/salt.tar.gz http://$download_bak/update/${filename}

	tar xzvf /home/lihongfu/update/salt.tar.gz -C "/tmp/"
	rpm -ivh /tmp/saltminion/*.rpm

fi
md5sum /home/lihongfu/update/salt.tar.gz 2>&1|awk '{print $1}' >/letv/soft/nginx/md5-salt
