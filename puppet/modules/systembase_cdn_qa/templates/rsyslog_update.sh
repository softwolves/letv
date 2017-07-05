#!/bin/bash

sed -i "/\/etc\/rsyslog.d\/\*.conf/d" /etc/rsyslog.conf
sed -i  "/ActionFileEnableSync/a \$IncludeConfig /etc/rsyslog.d/*.conf" /etc/rsyslog.conf
sed -i "/\*.emerg/d" /etc/rsyslog.conf
sed -i  "/emergency messages/a *.emerg                                                 :omusrmsg:*" /etc/rsyslog.conf

