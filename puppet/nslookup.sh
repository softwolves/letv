#!/bin/bash
ip=`nslookup t3.letvgslb.com|grep Address|tail -n 1|awk '{print $NF}'`
#ip=`nslookup e3.letvgslb.com|grep Address|tail -n 1|awk '{print $NF}'`
curl -is "http://mcache.oss.letv.com/mhresolve?domain=t3.letvgslb.com&host=$ip"
#curl -is "http://mcache.oss.letv.com/mhresolve?domain=e3.letvgslb.com&host=$ip"
