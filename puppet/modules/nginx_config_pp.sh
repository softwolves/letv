#!/bin/bash
if [ "$1" == "" ];then
	echo "error: Usage: nginx_config_pp.sh mode_name"
	exit 1
fi
if ` echo $1 | grep -q live `;then
	echo "$1 mode not support!!!!!!!"
	exit 1
fi
mode_name="$1"
config_pp="$1/manifests/config.pp"
back_config_pp="/tmp/${mode_name}_config.pp_bak"
\cp  $config_pp $back_config_pp
config_dir="$1/templates/"

static_dir="/usr/local/nginx
/usr/local/nginx/logs
/usr/local/nginx/sbin
/usr/local/nginx/html
/usr/local/nginx/conf/opscfg
/usr/local/nginx/conf/lualib/socket/
"
header="class $mode_name::config {"
dynamic_dir=`find  $config_dir -type d | grep -v vhosts | sort | sed 's/'$mode_name'\/templates/\/usr\/local\/nginx\/conf/g'`
dir_all="$dynamic_dir $static_dir"
echo $header > $config_pp
for i in $dir_all
do
        echo "    file {\"$i\": ensure => directory, }" >> $config_pp
done
echo "    file {\"/usr/local/nginx/conf/vhosts\": ensure => directory, owner => consul, }" >> $config_pp

file_conf="/usr/local/nginx/conf/lualib/socket/core.so
/usr/local/nginx/conf/lualib/cjson.so"

statuc_conf="/usr/local/nginx/html/50x.html
/usr/local/nginx/html/index.html
/usr/local/nginx/get_source.conf
"
dynamic_conf=`find  $config_dir -type f  | grep -v "\.html" | grep -v get_source.conf | grep -v md5-nginx | grep -v nginx_update.sh  | sort | sed 's/'$mode_name'\/templates\///g'`

for i in $statuc_conf
do
	echo -e "    file {\"$i\":\n        ensure => file,\n        mode => 644,\n        content => template(\"$mode_name/`echo $i | sed 's/.*\/\([^\/]*\)/\1/g'`\"),\n    }" >> $config_pp
done

for i in $dynamic_conf
do
	echo -e "    file {\"/usr/local/nginx/conf/$i\":\n        ensure => file,\n        mode => 644,\n        content => template(\"$mode_name/$i\"),\n    }" >> $config_pp
done

for i in $file_conf
do
	echo -e "    file {\"$i\":\n        ensure => file,\n        mode => 644,\n        source => \"puppet://\$fileserver/$mode_name/`echo $i | sed 's/.*\/\([^\/]*\)/\1/g'`\",\n    }" >> $config_pp
done

echo "    exec {\"/usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf -s reload\":" >> $config_pp
echo "        path => \"/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin\"," >> $config_pp
echo "        subscribe => [" >> $config_pp
for i in $dynamic_conf
do
	echo "            File[\"/usr/local/nginx/conf/$i\"]," >> $config_pp
done
for i in $file_conf
do
	echo "            File[\"$i\"]," >> $config_pp
done
echo "        ]," >> $config_pp
echo "        onlyif => '/usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf -t'," >> $config_pp
echo "        refreshonly => true," >> $config_pp
echo "    }" >> $config_pp
echo "}" >> $config_pp

diff $config_pp  $back_config_pp
