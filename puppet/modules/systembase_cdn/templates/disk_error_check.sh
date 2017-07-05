#!/bin/bash
# script:install.sh
#
#
# (c) 2015 , Tianbiao Zu <zutianbian@letv.com>
#
# 该脚本用于磁盘检查

##############################################################################
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
export PATH

restart_nginx() {
        echo "################################################################"
        echo "                  You will restart nginx"
        echo "################################################################"
        while `ps aux |grep '/usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf' |grep -qv grep `
        do
                killall -9 nginx
                sleep 2
        done

        ldconfig >/dev/null 2>&1
        sleep 2
	/usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf
        sleep 2
        echo
        echo ">>>>>>>>>>>>>>>>>>>>>>The nginx process<<<<<<<<<<<<<<<<<<<<<<<<"
        ps aux |grep nginx |head

        if [ $? -ne 0 ]
        then
        echo
        echo "****************nginx restart error******************"
        echo
        fi

        echo ">>>>>>>>>>>>>>>>>>>>>>The nginx process<<<<<<<<<<<<<<<<<<<<<<<<"
        echo
        sleep 2

}
check_disk() {
        #echo "==================================================================="
        #echo "  This step will check disk      "
        #echo "==================================================================="
# frist disk
        #echo -----------------------------------------
        #diskname=$1
        #df -lh|grep -q "/letv/fet"
        #if [ "$?" -ne "0" ]
        #then
        #       echo "mkdir  /letv/fet"
        #        mkdir -p /letv/fet
        #       mkfs.xfs -n size=8k -d su=1m,sw=10 -f /dev/$diskname
        #       mount -t  xfs  -o nobarrier /dev/$diskname /letv/fet
        #       /sbin/blockdev --setra 1024 /dev/$diskname
        #else
        #       echo "/letv/fet is mounted normal"
        #fi
        echo -----------------------------------------
        echo `date` > /letv/fet/disk_check_heartbeats
        if [ "$?" -ne "0" ]
        then
                echo "disk error,shutdown gslb report"
                cat /etc/hosts|grep -q "1.1.1.1\s*report.gslb.letv.com"
                if [ "$?" -ne "0" ]
                then
                        sed -i 's/^.*report.gslb.letv.com/#&/g' /etc/hosts
                        echo "1.1.1.1    report.gslb.letv.com" >> /etc/hosts
                        restart_nginx
                        /etc/init.d/dnsmasq reload
                fi
        else
                cat /etc/hosts|grep -q "1.1.1.1\s*report.gslb.letv.com"
                if [ "$?" -eq "0" ]
                then
                        echo "disk back to normal"
                        sed -i '/^\s*1.1.1.1\s*report.gslb.letv.com/d' /etc/hosts
                        sed -i '/^\s*#.*report.gslb.letv.com/s/^\s*#//g'  /etc/hosts
                        restart_nginx
                        /etc/init.d/dnsmasq reload
                else
                        echo "disk normal"
                fi
        fi
        echo -----------------------------------------
}
check_disk
