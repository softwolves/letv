#!/bin/bash
source ~/.bash_profile
logs_path="/usr/local/letv/"
logdate=`date '+%Y%m%d%H%M' -d "-1 hours"`
error_log='/usr/local/nginx/logs/error.log'
cd $logs_path
mv  access.log  access_${logdate}.log
mv $error_log error_${logdate}.log
kill -USR1 $(cat /usr/local/nginx/logs/nginx.pid)
tar czvf  access_${logdate}.tar.gz  access_${logdate}.log
tar czvf  error_${logdate}.tar.gz error_${logdate}.log
rm -rf  access_${logdate}.log error_${logdate}.log
find . -name "access_*.gz"   -mtime +2 -exec rm  {} \;
find . -name "error_*.gz"   -mtime +2 -exec rm  {} \;
find . -name "access_*.*.tmp"  -exec rm  {} \;
