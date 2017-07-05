#!/bin/bash
# newcdn ats records.config

tmp_conf="/etc/trafficserver/records.config_tmp"
record_conf="/etc/trafficserver/records.config"
store_conf="/etc/trafficserver/storage.config"
disk_key=0
ssd_key=0
function get_root_disk()
{
	echo `lsblk  -nl | grep SWAP | awk '{print $1}' | grep -o "[a-z]*"`
}

root_disk=$(get_root_disk)

function get_local_disk()
{
	echo `lsblk  -nl  | grep disk  | grep 5.5T | grep -v letv |awk '{print "/dev/"$1}'| grep -v $root_disk | sort`
}

function get_conf_disk()
{
	echo `grep -v "^#" $store_conf | grep "/dev" | sort -u`
}

function get_local_ssd()
{
	echo `lsblk  -nl  | grep disk  | grep -v 5.5T | awk '{print "/dev/"$1}' | grep -v $root_disk | sort`
}

function get_conf_ssd()
{
	if [ -f $record_conf ];then
		ssd=`grep proxy.config.cache.interim.storage $record_conf | grep -v "#" | grep -o "/dev/[a-z]*" | sort -u`
		echo $ssd
	else
		echo ""
	fi
}

ssd_disk=$(get_local_ssd)
conf_ssd=$(get_conf_ssd)
if [ "$ssd_disk" == "" ];then
	cp -f $tmp_conf $record_conf
	sed -i '/proxy.config.cache.interim.storage/d' $record_conf
	/usr/bin/traffic_line -x
elif [ "$ssd_disk" == "$conf_ssd" ];then
	cp -f $tmp_conf $record_conf
	sed -i '/proxy.config.cache.interim.storage/d' $record_conf
	echo "LOCAL proxy.config.cache.interim.storage STRING $ssd_disk" >> $record_conf
        /usr/bin/traffic_line -x
else
	cp -f $tmp_conf $record_conf
        sed -i '/proxy.config.cache.interim.storage/d' $record_conf
        echo "LOCAL proxy.config.cache.interim.storage STRING $ssd_disk" >> $record_conf
	ssd_key=1
fi

cache_disk=$(get_local_disk)
conf_disk=$(get_conf_disk)
disk_list=`echo $cache_disk$ssd_disk | sed -e 's/ //g' -e 's/\/dev\/sd//g'`
echo "SUBSYSTEM==\"block\", KERNEL==\"sd[$disk_list]\", OWNER=\"ats\",GROUP=\"ats\"" >/etc/udev/rules.d/99-ats.rules
/sbin/udevadm trigger --subsystem-match=block

if [ "$cache_disk" != "$conf_disk" ];then
	echo $cache_disk | sed 's/ /\n/g'
	echo $cache_disk | sed 's/ /\n/g' >  $store_conf
	disk_key=1
fi

if [ $disk_key -eq 1 -o $ssd_key -eq 1 ];then
	/etc/init.d/trafficserver restart
fi

grep -q /etc/trafficserver/records.config.sh /etc/rc.local
if [ $? -ne 0 ];then
	echo /etc/trafficserver/records.config.sh >> /etc/rc.local
fi
