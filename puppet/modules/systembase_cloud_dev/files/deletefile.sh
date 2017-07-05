#/bin/bash
cd /home/lihongfu/
#delete core file
ls -lt core.*| awk '{print $NF}' |sed -n '4,$p'| xargs -i rm -rf {}

#delete curl test file
if [ -d /letv/fet/dataspeed/ ];then
ls -lt /letv/fet/dataspeed/curl*| awk '{print $NF}' |sed -n '700,$p' | xargs -i rm -rf {}
echo OK
fi
#delete wget report file
if [ -f /dev/shm/total_wget_report ];then

mv /dev/shm/total_wget_report /dev/shm/total_wget_report.bak
tail -200 /dev/shm/total_wget_report.bak > /dev/shm/total_wget_report

fi
