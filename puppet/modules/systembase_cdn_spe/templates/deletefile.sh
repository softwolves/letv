#/bin/bash
cd /home/lihongfu/
#delete core file
ls -lt core.*| awk '{print $NF}' |sed -n '4,$p'| xargs -i rm -rf {}

#delete curl test file
if [ -d /letv/fet/dataspeed/ ];then
ls -lt /letv/fet/dataspeed/curl*| awk '{print $NF}' |sed -n '700,$p' | xargs -i rm -rf {}
ls -lt /letv/fet/downfile/dataspeed/curl*| awk '{print $NF}' |sed -n '700,$p' | xargs -i rm -rf {}
#echo OK
fi
#delete wget report file
if [ -f /dev/shm/total_wget_report ];then

mv /dev/shm/total_wget_report /dev/shm/total_wget_report.bak
tail -200 /dev/shm/total_wget_report.bak > /dev/shm/total_wget_report

fi
###delete crtmp log
find /usr/local/rtmp/r2h/ -name "access_*" -ctime +10 |xargs -i rm -rf {}
find /usr/local/rtmp/r2h/ -name "r2h_*" -ctime +10 |xargs -i rm -rf {}
find /usr/local/rtmp/r2h/ -name "access_*" -size +2G |while read line;do cat /dev/null > $line;done
find /usr/local/rtmp/r2h/ -name "r2h_*" -size +2G |while read line;do cat /dev/null > $line;done
##### delete ats core log
find /usr/local/sbin/ats/ -name "core.*"  -cmin +30 |xargs -i rm -rf {}
##### deletc /letv core-
find /letv/ -maxdepth 1  -name "core-*" -cmin +720 |xargs -i rm -rf {}
#####delete nginx core
find /tmp -maxdepth 1  -name "core.*" |xargs -i rm -rf {}
find / -maxdepth 1  -name "core.*" |xargs -i rm -f {}
find /home/update/core/ -maxdepth 1  -name "core.*" -mmin +720 |xargs -i rm -f {}
