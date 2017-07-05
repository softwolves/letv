#!/bin/bash
# script:cto_install.sh
#
#
# (c) 2015 , Tianbiao Zu <zutianbian@letv.com>
#
# 该脚本用于安装并配置cto加速

##############################################################################
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin
export PATH

CTO_TAR_FILENAME="cto_server_1.1.1-CentOS6-x64.tar"

##################################################################
# 函数 install()
# 功能 安装cto
# 参数:
#      无
# 返回值:
#      iptables信息以及cto web页面端口监听
#
##################################################################
function install(){
    if [ ! -f "/root/$CTO_TAR_FILENAME" ];then
        cd
        wget -q "http://115.182.94.72/$CTO_TAR_FILENAME" -O /root/$CTO_TAR_FILENAME > /dev/null 2>&1
        tar xf $CTO_TAR_FILENAME > /dev/null 2>&1
        cto_dirname=`echo "$CTO_TAR_FILENAME"|awk -F '.tar' '{print $1}'`
        cd $cto_dirname
        if [ -f "/cto/bin/ctostart" ];then
            sh install.sh -u> /dev/null 2>&1
            sed -i '/socket_port/s/5000/5001/g' /cto/www/cto.conf
            sed -i '/socket_host/s/0.0.0.0/127.0.0.1/g' /cto/www/cto.conf
            /cto/bin/ctorestart > /dev/null 2>&1
        else
            sh install.sh > /dev/null 2>&1
            sed -i 's/install nf_conntrack/#install nf_conntrack/g' /etc/modprobe.d/nf_conntrack.conf
            modprobe iptable_nat;modprobe nf_conntrack
            sed -i '/socket_port/s/5000/5001/g' /cto/www/cto.conf
            sed -i '/socket_host/s/0.0.0.0/127.0.0.1/g' /cto/www/cto.conf
            /cto/bin/ctostart > /dev/null 2>&1
        fi
    fi
    usermod -p abg9iJfSduHbY  ctoadmin
    sysctl -p
    iptables -L -t nat
    netstat -ntlp|grep python
}
install
