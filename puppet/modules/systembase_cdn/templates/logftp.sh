#!/bin/bash
if [ -f "/usr/local/etc/logftp2.pl" ];then
/usr/bin/perl /usr/local/etc/logftp2.pl >/dev/null 2>&1
fi
