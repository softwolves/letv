#!/bin/bash
#power by duhaibin@letv.com
##raid信息检查0 ok  1 error
raid_s=0
##raid工具检查0 ok  1 error
raid_t=0
##disk_e o ok 1 warning 2 error
disk_e=0
##read_e o ok 1 warning
read_e=0
##xfs_e o ok 1 error
xfs_e=0
##puppet_e 0 ok 1 error
puppet_e=0
##report_e 0 ok 1 error
report_e=0
##nginx_e 0 ok 1 error
nginx_e=0



raidcheck(){
if lspci | grep -E 'MegaRAID' | grep -Ev 'Fusion-MPT SAS-2' >/dev/null 2>&1;then
    if [ ! -f /opt/MegaRAID/MegaCli/MegaCli64 ];then
        raid_t=1
    else
	num_m=`ps aux | grep MegaCli64| grep -Ev grep  | wc -l`
	if [ $num_m -gt 3 ];then
	    pkill -9 MegaCli64
        fi
	num=`/opt/MegaRAID/MegaCli/MegaCli64 -PDLIST -AALL |grep -Ei  'Firmware state'|grep -Ei 'Offline|Spun down' | wc -l`
	if [ $num -ge 3 ];then
            disk_e=2    
	elif [ $num -lt 3  -a  $num -ge 1 ];then
	    disk_e=1
	fi
    fi
elif lspci  | grep RAID| grep -Ei 'Smart Array' >/dev/null 2>&1;then
    if [ ! -f /usr/sbin/hpssacli ];then
        raid_t=1
    else
        num_m=`ps aux | grep hpssacli | grep -Ev grep | wc -l`
        if [ $num_m -gt 3 ];then
            pkill -9 hpssacli
        fi
        slot="`/usr/sbin/hpssacli ctrl all show status|grep -i slot |sed 's, ,\n,g'| grep '^[0-9]$' `"
	num="`/usr/sbin/hpssacli ctrl slot=$slot pd all show| grep -Ei 'Failed'|wc -l`"
        if [ $num -ge 3 ];then
            disk_e=2
        elif [ $num -lt 3 -a  $num -ge 1 ];then
            disk_e=1
        fi
    fi

else
    raid_s=1
fi
}

xfs_check(){

    if ! echo `date` > /letv/fet/disk_check_heartbeats > /dev/null 2>&1 ;then
	read_e=1	
    elif ! echo `date` > /usr/local/letv/disk_check_heartbeats > /dev/null 2>&1 ;then
	read_e=1
    fi

    if tail -200 /var/log/messages | grep -E 'xfs_log_force'|grep -E 'error' > /dev/null 2>&1;then 
	xfs_e=1	
    fi

}


hostname_check(){
    if grep -Ev "#" /etc/hosts | grep -E "puppet.oss.letv.com"| grep -Ev "117.121.54.74"  > /dev/null 2>&1;then
	puppet_e=1
    fi

    if grep -Ev "#" /etc/hosts | grep -E "report.gslb.letv.com"  > /dev/null 2>&1;then
	report_e=1        
    fi
}


nginx_check(){

    if ps aux |grep -Ev grep |grep nginx.conf.1 > /dev/null 2>&1;then
        nginx_e=1
    elif ps aux |grep -Ev grep |grep nginx.conf.bak > /dev/null 2>&1;then
        nginx_e=1
    fi


}
raidcheck  > /dev/null 2>&1
xfs_check   > /dev/null 2>&1
hostname_check  > /dev/null 2>&1
nginx_check  > /dev/null 2>&1

cat > /dev/shm/syscheck << _EOF_
raid_s $raid_s
raid_t $raid_t
disk_e $disk_e
read_e $read_e
xfs_e $xfs_e
puppet_e $puppet_e
report_e $report_e
nginx_e $nginx_e
_EOF_
