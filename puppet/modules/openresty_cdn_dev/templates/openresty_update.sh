#!/bin/bash
#Power by duhaibin@letv.com
#2014年 02月 27日 星期四 14:42:40 CST
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
lockfile='/var/run/update_openresty.pid'
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


openresty_md5="`cat /letv/soft/nginx/md5-openresty`"

if [ ! -d /home/lihongfu/update ]
then
        mkdir -p /home/lihongfu/update/
fi

download_addr="test.coop.gslb.letv.com"
download_bak="115.182.94.72"

filename="openresty.tar.gz_${openresty_md5}"
        rm -rf /home/lihongfu/update/openresty.tar.gz
if wget -t 2 -T 30 -c -N -q -O /home/lihongfu/update/openresty.tar.gz http://$download_addr/update/${filename} ;then
	tar xzvf /home/lihongfu/update/openresty.tar.gz -C "/"
	pkill -9 openresty
	/usr/local/openresty/nginx/sbin/openresty -c /usr/local/openresty/nginx/conf/nginx.conf
#	find /livemem -type f| xargs rm -f 	
else
        rm -rf /home/lihongfu/update/openresty.tar.gz
	 wget -t 2 -T 30 -c -N -q -O /home/lihongfu/update/openresty.tar.gz http://$download_bak/update/${filename}
        tar xzvf /home/lihongfu/update/openresty.tar.gz -C "/"
        pkill -9 openresty
        /usr/local/openresty/nginx/sbin/openresty -c /usr/local/openresty/nginx/conf/nginx.conf
#	find /livemem -type f| xargs rm -f 
fi
md5sum /home/lihongfu/update/openresty.tar.gz 2>&1|awk '{print $1}' >/letv/soft/nginx/md5-openresty
