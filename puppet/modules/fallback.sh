#!/bin/bash
#cd /letv/jihaipeng/puppetxo/modules
while ((1))
do
	read -p "---输入要回退的模块名:" mode_name
	if [ ! -d $mode_name ];then
		echo -e "\033[31m---模块名不存在，请重新输入!\033[0m"
		continue
	fi
	read -p "---输入要回退的版本号:" version
	echo -e "\033[32m---查询对应的git版本号如下:\033[0m\n"
	git log --follow $mode_name | grep -B 4 "${mode_name}:${version}:"
	if [ $? -ne 0 ];then
		echo -e "\033[31m---未找到 $mode_name $version 版本信息，请确认！\033[0m"
		exit 1
	else
		read -p "---输入回退的git版本号(commit):" fallback_id
	fi
	echo -e "\033[32m---升级信息如下，请确认:\033[0m\n"
	echo -e "|模块名|\t|版本|\t|git版本|\n|$mode_name|\t|$version|\t|$fallback_id|" | column -t 
	while ((1))
	do
		read -n 1 -p "---确认 [Y/N]?" answer
		case $answer in
			Y|y|N|n)
				break;;
			*)
				continue;;
		esac
		echo
	done
	if [ "$answer" == "Y" -o "$answer" == "y" ];then
		break
	fi
done
#mode_name=$1
#version=$2
#
#function get_id()
#{
#	git log --follow $mode_name | grep -B 4 "A${version}B" | head -n 1 | awk '{print $2}'
#}
##git log --follow $mode_name | grep -B 4 "A$2B" | head -n 1
#
#fallback_id=`get_id`
#
echo
git reset --hard $fallback_id &> /dev/null
if [ $? -eq 0 ];then
	echo -e "\033[32m---模块 $mode_name 本地版本库回退成功.\033[0m"
else
	echo -e "\033[31m---模块 $mode_name 本地版本库回退失败,无此git版本.\033[0m"
	exit 1
fi
[ ! -d /tmp/git/fallback ] && mkdir -p /tmp/git/fallback
rm -rf /tmp/git/fallback/$mode_name
echo "---从本地库复制 $mode_name 配置到 /tmp/git/fallback/."
cp -r $mode_name /tmp/git/fallback/
echo "---同步本地库到最新版 git pull."
git pull &> /dev/null
bak_mode="${mode_name}_${version}_`date +%Y%m%d%H%M%S`"
echo "---备份最新git库 $mode_name 模块为 $bak_mode"
git mv $mode_name $bak_mode
echo "---从/tmp/git/fallback/ 恢复模块 $mode_name 到本地git库."
cp -r /tmp/git/fallback/$mode_name .

echo -e "\033[32m---执行git status -s:\033[0m"
echo "**************************"
git status -s
echo "**************************"

while ((1))
do
	read -n 1 -p "---本地库已经恢复，是否提交到远程库 [Y(提交到远程库)/N(撤销本次更改)]?" answer
	if [ "$answer" == "Y" -o "$answer" == "y" ];then
		cd ../
		echo
		git add * 
		git commit -m "${mode_name}:fallback from version $version"
		git push
		echo "----------------------------------------"
		echo "|  远程git库回退完成，请进行单台测试.  |"
		echo "----------------------------------------"
		echo  -e "\033[32m---正在同步测试环境puppet.\033[0m"
		ansible-playbook -i puppet_test /root/git.yml
		break
	elif [  "$answer" == "N" -o "$answer" == "n" ];then
		echo
		cd ../
		echo -e "\033[31m---执行本地git库恢复，撤销更改.\033[0m"
		git reset --hard
		git clean -xdf
		echo "---回退后状态检查，git status -s"
		echo '**********************'
		git status -s 
		echo '**********************'
		break
	else
		echo -e "\033[31m---输入非法，请重新输入.\033[0m"
		
	fi
done


while ((1))
do
	read -n 1 -p "---请确认单台测试是否成功，继续下一步同步git库到生产环境puppet [Y/N]?" answer
	echo
	if [ "$answer" == "Y" -o "$answer" == "y" ];then
		echo  -e "\033[32m---正在同步生产环境puppet.\033[0m"
		ansible-playbook -i hosts /root/git.yml
		echo  -e "\033[32m---puppet回退完成.\033[0m"
		exit 0
	elif [  "$answer" == "N" -o "$answer" == "n" ];then
		echo -e "\033[31m---回退测试失败，请进行手工回退或回退其他版本.\033[0m"
		exit 1
        else
                echo -e "\033[31m---输入非法，请重新输入.\033[0m"

        fi
done
