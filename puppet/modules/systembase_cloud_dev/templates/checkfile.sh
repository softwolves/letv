#!/bin/bash
#power by duhaibin@letv.com
#2014-07-21 17:50:46
unset HISTFILE
PATH="/usr/kerberos/sbin:/usr/kerberos/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin"
export PATH
export LANG="en_CN.UTF-8"
checktime=`date '+%Y%m%d'`

path="/home/lihongfu/analyzelog/"
host_name=`hostname`
if echo $host_name| grep -Ei 'store';then

if [ ! -d $path ];then
mkdir -p $path
fi

if [ ! -f ${path}error_${checktime} ];then
	touch ${path}error_${checktime}
fi

if [ -f /usr/local/letv/access.log ];then
	cat /usr/local/letv/access.log  | awk '{if ($8~/404/)print $6}' | awk -F'?' '{print $1}'  | sort | uniq -c | awk  '{print $2}' > ${path}404file

fi

while read line
do
	if echo $line| grep -E '.mp4' ;then
		if [  -f "/letv/fet${line}" ];then
			if ! grep $line ${path}error_${checktime};then
				echo $line >> ${path}error_${checktime}
			fi
		fi

	fi


done<${path}404file

#find $path -name error_* -ctime +7  -exec  rm  {} \;
ls -lt /home/lihongfu/analyzelog/error_* | awk '{print $NF}' | sed -n '7,$p' | xargs -i rm -rf {}

fi

