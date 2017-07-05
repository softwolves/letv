#!/bin/sh
mysql -hlocalhost -uredmine -pmy_password <<EOF
use redmine;
#select * from tb_node_info;     
#select host from tb_node_member_info where node_id=$1 and state=1;
#select name from hosts;
select ip from hosts;
#select host from tb_node_member_info where node_id in (SELECT node_id FROM tb_node_info WHERE NODE_TYPE=0 and STATE=0) and state=1;
EOF
