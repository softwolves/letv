#/bin/bash
#power by duhaibin@letv.com
#统计晚高峰期间点播日志命中率
path=/usr/local/letv/
filedate=`date --date "6 hours ago" +"%Y%m%d%H"`
filenamegz="access_${filedate}00.tar.gz"
filename="access_${filedate}00.log"
echo $filename >>/tmp/cdnlogcheck.log
tar -zxvf ${path}${filenamegz} -C /tmp
######过滤日志
cat /tmp/${filename} | grep "playid=0" |awk  '{if ($8~/200|206/)print}' |grep -Ev  '\.m3u8' |grep '\.ts\?' |awk  '{for(i=14;i<NF;i++)if($i~/^HIT|^MISS/)print $6,$i}' |sed -n 's/.*platid=\(.\).* \(.\)/\1 \2/p'|sort -n| uniq -c | awk '{if($3=="HIT"){h[$2]+=$1};s[$2]+=$1}END{for(a in s){print a,h[a]/s[a]*100,h[a],s[a]}}' > /dev/shm/cdn_0_ts
cat /tmp/${filename} | grep "playid=0" |awk  '{if ($8~/200|206/)print}' |grep -Ev  '\.m3u8' |grep '\.mp4\?'|awk  '{for(i=14;i<NF;i++)if($i~/^HIT|^MISS/)print $6,$i}' |sed -n 's/.*platid=\(.\).* \(.\)/\1 \2/p' |sort -n | uniq -c |awk '{if($3=="HIT"){h[$2]+=$1};s[$2]+=$1}END{for(a in s){print a,h[a]/s[a]*100,h[a],s[a]}}' > /dev/shm/cdn_0_mp4
cat /tmp/${filename} | grep "playid=1" |awk  '{if ($8~/200|206/)print}' |grep -Ev  '\.m3u8' |awk  '{for(i=14;i<NF;i++)if($i~/^HIT|^MISS/)print $6,$i}' |sed -n 's/.*platid=\(.\).* \(.\)/\1 \2/p'|sort -n| uniq -c |awk '{if($3=="HIT"){h[$2]+=$1};s[$2]+=$1}END{for(a in s){print a,h[a]/s[a]*100,h[a],s[a]}}' > /dev/shm/down_2
#####删除解压后的日志
if [ -f /tmp/${filename} ];then
rm -f /tmp/${filename}
fi
