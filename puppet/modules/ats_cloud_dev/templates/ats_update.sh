#!/bin/bash
#Power by duhaibin@letv.com
#2015-07-17 16:32:28
#通过ansible升级ats二进制文件
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
lockfile="/var/run/ansible_update_ats.pid"

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


start_ats() {
        /etc/init.d/trafficserver restart &> /dev/null
        if [ $? -eq 0 ];then
                return 0
        else
		return 1
        fi
}

if [ ! -d /home/update/puppetmd5file ];then
        mkdir -p /home/update/puppetmd5file
        mkdir -p /home/update/file
	mkdir -p /home/update/shell
fi


download_cloud="test.coop.gslb.letv.com"
download_all="115.182.94.72"
update_ats_md5="`cat /home/update/puppetmd5file/md5-ats`"
run_ats_md5="`md5sum /home/update/file/letv_trafficserver.tar.gz | awk '{print $1}'`"
filename_update="letv_trafficserver.tar.gz_${update_ats_md5}"
filename_run="letv_trafficserver.tar.gz_${run_ats_md5}"

if [ "$filename_update" != "$filename_run" ];then
#########判断备份目录是否有当前运行的ats，如果没有就备份一下
    if [ ! -f /home/update/file/${filename_run} ];then
        cp -f /home/update/file/letv_trafficserver.tar.gz /home/update/file/letv_trafficserver.tar.gz_${run_ats_md5}
        ls -lt /home/update/file/letv_trafficserver.tar.gz_*| awk '{print $NF}' |sed -n '8,$p'| xargs -i rm -rf {}
    fi    

#########检查备份目录是否有要更新的文件
    if [ -f /home/update/file/letv_trafficserver.tar.gz_${update_ats_md5} ];then
        ats_bak_md5="`md5sum /home/update/file/letv_trafficserver.tar.gz_${update_ats_md5} | awk '{print $1}'`"
        if [ "$update_ats_md5" = "$ats_bak_md5" ];then
            tar xzvf /home/update/file/letv_trafficserver.tar.gz_${update_ats_md5} -C "/"
            start_ats
	    cp /home/update/file/letv_trafficserver.tar.gz_${update_ats_md5} /home/update/file/letv_trafficserver.tar.gz
        else
            mv -f /home/update/file/letv_trafficserver.tar.gz_${update_ats_md5} /home/update/file/letv_trafficserver.tar.gz_${ats_bak_md5} 
        fi
    else
	rm -rvf /home/update/file/letv_trafficserver.tar.gz
        wget -t 2 -T 30 -c -N -q -O /home/update/file/letv_trafficserver.tar.gz http://$download_cloud/update/${filename_update}
        ats_tmp_md5="`md5sum /home/update/file/letv_trafficserver.tar.gz | awk '{print $1}'`"
        if [ "$update_ats_md5" = "$ats_tmp_md5" ]
        then
            tar xzvf /home/update/file/letv_trafficserver.tar.gz -C "/"
            #tar xzvf /home/lihongfu/update/letv_trafficserver.tar.gz -C "/"
	    start_ats 
        else
	    rm -rvf /home/update/file/letv_trafficserver.tar.gz
            wget -t 2 -T 30 -c -N -q -O /home/update/file/letv_trafficserver.tar.gz http://$download_all/update/${filename_update}
            ats_tmp_sec_md5="`md5sum /home/update/file/letv_trafficserver.tar.gz | awk '{print $1}'`"
            if [ "$update_ats_md5" = "$ats_tmp_sec_md5" ];then
            tar xzvf /home/update/file/letv_trafficserver.tar.gz -C "/"
            #tar xzvf /home/lihongfu/update/letv_trafficserver.tar.gz -C "/"
            start_ats
            fi
        fi
    fi
fi


md5sum /home/update/file/letv_trafficserver.tar.gz 2>&1|awk '{print $1}' > /home/update/puppetmd5file/md5-ats

