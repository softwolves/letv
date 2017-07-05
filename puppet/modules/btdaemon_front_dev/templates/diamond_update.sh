#!/bin/bash
#Power by jihaipeng@letv.com
#2015-07-17 16:32:28
#通过ansible升级diamond二进制文件
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
lockfile="/var/run/ansible_update_diamond.pid"

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


stop_diamond() {
        killall -9 diamond
        sleep 2
        killall -9 diamond
        sleep 1
        killall -9 diamond
	if [ -f /var/run/diamond.pid ];then
		rm -f /var/run/diamond.pid
	fi
}

start_diamond() {
	/etc/init.d/diamond restart
}


if [ ! -d /home/update/puppetmd5file ]
then
        mkdir -p /home/update/puppetmd5file
        mkdir -p /home/update/md5file
        mkdir -p /home/update/file
	mkdir -p /home/update/shell
fi


download_cloud="test.coop.gslb.letv.com"
download_all="115.182.94.72"
update_diamond_md5="`cat /home/update/puppetmd5file/md5-diamond`"
run_diamond_md5="`md5sum /home/update/file/diamond.rpm | awk '{print $1}'`"
filename_update="diamond_${update_diamond_md5}"
filename_run="diamond_${run_diamond_md5}"

if [ "$filename_update" != "$filename_run" ]
then
#########判断备份目录是否有当前运行的diamond，如果没有就备份一下
    if [ ! -f /home/update/file/${filename_run} ];then
        cp -f /home/update/file/diamond.rpm /home/update/file/${filename_run}
        ls -lt /home/update/file/diamond_*| awk '{print $NF}' |sed -n '8,$p'| xargs -i rm -rf {}
    fi    

#########检查备份目录是否有要更新的文件
    if [ -f /home/update/file/${filename_update} ];then
        diamond_bak_md5="`md5sum /home/update/file/${filename_update} | awk '{print $1}'`"
        if [ "$update_diamond_md5" = "$diamond_bak_md5" ];then
                cp -f /home/update/file/${filename_update} /home/update/file/diamond.rpm
		stop_diamond
                cp -f /etc/diamond/diamond.conf /tmp/diamond.conf
		rpm -e diamond
                rpm -i /home/update/file/diamond.rpm
                cp -f /tmp/diamond.conf /etc/diamond/diamond.conf
		start_diamond
        else
            mv -f /home/update/file/${filename_update} /home/update/file/diamond_${diamond_bak_md5} 
        fi
    else
        rm -rf /home/update/file/diamond.rpm_tmp
        wget -t 2 -T 30 -c -N -q -O /home/update/file/diamond.rpm_tmp http://$download_cloud/update/${filename_update}
        diamond_tmp_md5="`md5sum /home/update/file/diamond.rpm_tmp | awk '{print $1}'`"
        if [ "$update_diamond_md5" = "$diamond_tmp_md5" ]
        then
                cp -f /etc/diamond/diamond.conf /tmp/diamond.conf
                stop_diamond
                rpm -e diamond
                cp -f /tmp/diamond.conf /etc/diamond/diamond.conf
                rpm -i /home/update/file/diamond.rpm_tmp
                mv /home/update/file/diamond.rpm_tmp /home/update/file/diamond.rpm 
                start_diamond
        else
            wget -t 2 -T 30 -c -N -q -O /home/update/file/diamond.rpm_tmp http://$download_all/update/${filename_update}
            diamond_tmp_sec_md5="`md5sum /home/update/file/diamond.rpm_tmp | awk '{print $1}'`"
            if [ "$update_diamond_md5" = "$diamond_tmp_sec_md5" ];then
                cp -f /etc/diamond/diamond.conf /tmp/diamond.conf
                stop_diamond
                rpm -e diamond
                cp -f /tmp/diamond.conf /etc/diamond/diamond.conf
                rpm -i /home/update/file/diamond.rpm_tmp
                mv /home/update/file/diamond.rpm_tmp /home/update/file/diamond.rpm    
                start_diamond
            fi
        fi
    fi
fi


md5sum /home/update/file/diamond.rpm 2>&1|awk '{print $1}' > /home/update/puppetmd5file/md5-diamond
