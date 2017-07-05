#!/bin/bash
data=`date -d "yesterday" +"%Y%m%d"`
cd /etc/puppet/
#sed -i -e '/ip      name/d' nameip 
cat ./nameip /etc/hosts | sort | uniq > ./hosts 
mv /etc/hosts /letv/hosts.$data
cp ./hosts /etc/hosts
