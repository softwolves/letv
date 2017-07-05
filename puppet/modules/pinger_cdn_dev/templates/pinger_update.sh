#!/bin/bash
#Power by jihaipeng@letv.com
#Tue Mar  8 10:47:59 CST 2016
#通过puppet升级pinger二进制文件
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
lockfile="/var/run/update_pinger.pid"

#single instance
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


stop_pinger() {
        pkill -9 pinger
        sleep 2
	pkill -9 pinger
        sleep 1
	pkill -9 pinger
        rm -f /var/run/pinger.pid
}

start_pinger() {
        chmod 755 /usr/local/sbin/pinger
        ulimit -c unlimited
        [ -d /letv/fet/greenping/ ] || mkdir -p /letv/fet/greenping/
        #/usr/local/sbin/pinger --daemon --ping-retention=72h --db=/letv/fet/greenping/db --tag=/letv/fet/greenping/tag --center=ws://greenping.g3gather.lecloud.com/register
	#/usr/local/sbin/pinger -center ws://greenping.g3gather.lecloud.com/register?iplist=
	/usr/local/sbin/pinger --daemon --center=117.121.54.101:443 --dns-config="dns_addr=127.0.0.1:5053" --api=127.0.0.1:909
}

if [ ! -f /usr/local/sbin/pinger ]
then
        touch /usr/local/sbin/pinger
fi

if [ ! -d /home/update/puppetmd5file ]
then
        mkdir -p /home/update/puppetmd5file
        mkdir -p /home/update/md5file
        mkdir -p /home/update/file
	mkdir -p /home/update/shell
fi


download_cloud="test.coop.gslb.letv.com"
download_all="115.182.94.72"
update_pinger_md5="`cat /home/update/puppetmd5file/md5-pinger`"
run_pinger_md5="`md5sum /usr/local/sbin/pinger | awk '{print $1}'`"
filename_update="pinger_${update_pinger_md5}"
filename_run="pinger_${run_pinger_md5}"

if [ "$filename_update" != "$filename_run" ]
then
#########判断备份目录是否有当前运行的pinger，如果没有就备份一下
    if [ ! -f /home/update/file/${filename_run} ];then
        cp -f /usr/local/sbin/pinger /home/update/file/${filename_run}
        ls -lt /home/update/file/pinger_*| awk '{print $NF}' |sed -n '8,$p'| xargs -i rm -rf {}
    fi    

#########检查备份目录是否有要更新的文件
    if [ -f /home/update/file/${filename_update} ];then
        pinger_bak_md5="`md5sum /home/update/file/${filename_update} | awk '{print $1}'`"
        chmod 755 /home/update/file/${filename_update}
        if [ "$update_pinger_md5" = "$pinger_bak_md5" ];then
		stop_pinger
		rm -rf /usr/local/sbin/pinger
                cp -f /home/update/file/${filename_update} /usr/local/sbin/pinger
		start_pinger
        else
            mv -f /home/update/file/${filename_update} /home/update/file/pinger_${pinger_bak_md5} 
        fi
    else
        rm -rf /usr/local/sbin/pinger_tmp
        wget -t 2 -T 30 -c -N -q -O /usr/local/sbin/pinger_tmp http://$download_cloud/update/${filename_update}
        pinger_tmp_md5="`md5sum /usr/local/sbin/pinger_tmp | awk '{print $1}'`"
        chmod 755 /usr/local/sbin/pinger_tmp
        if [ "$update_pinger_md5" = "$pinger_tmp_md5" ]
        then
                if [ -s /usr/local/sbin/pinger_tmp ];then
                    stop_pinger
                    rm -rf /usr/local/sbin/pinger
                    mv /usr/local/sbin/pinger_tmp /usr/local/sbin/pinger
                    start_pinger
                fi
        else
            wget -t 2 -T 30 -c -N -q -O /usr/local/sbin/pinger_tmp_sec http://$download_all/update/${filename_update}
            chmod 755 /usr/local/sbin/pinger_tmp_sec
            pinger_tmp_sec_md5="`md5sum /usr/local/sbin/pinger_tmp_sec | awk '{print $1}'`"
            if [ "$update_pinger_md5" = "$pinger_tmp_sec_md5" ];then
                    if [ -s /usr/local/sbin/pinger_tmp_sec ];then
                        stop_pinger
                        rm -rf /usr/local/sbin/pinger
                        mv /usr/local/sbin/pinger_tmp_sec /usr/local/sbin/pinger
                        start_pinger
                    fi
            fi
        fi
    fi
fi


md5sum /usr/local/sbin/pinger 2>&1|awk '{print $1}' > /home/update/puppetmd5file/md5-pinger
