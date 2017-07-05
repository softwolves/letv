#####front测试节点9989  9991
#node /front-hb-lf-cnc-80/,/^front-tj-bgp-\d+/,/^front-zj-ls-ctc-\d+/,/^front-tj-ctc-\d+/ {
#node /front-hb-lf-cnc-80/,/^front-tj-ctc-\d+/,/front-gd-dg-ctc-\d+/,/front-zj-ls-ctc-\d+/,/front-js-yz-bgp-\d+/,/front-tj-bgp-\d+/ {
#node /front-hb-lf-cnc-80/,/^front-tj-ctc-\d+/,/^front-hk-heji-\d+/ {
#node /front-js-xz-ctc3-.*/,/^front-sd-jn-cnc.*/,/^front-tj-ctc.*/,/^front-tj-dg-ctc3-\d+/,/^front-bj-ctc-cnc-1/,/^front-bj-ctc-cnc-2/ {
#  include puppet_all
#  include systembase_front_new
#  include watchdog_front_dev
#  include btdaemon_front_dev
#  include zabbix_all
#  include ats_front_dev
#  include nginx_front_new
#  include cagent_front_dev
#  include rtmp_front_dev

#  include cto2_all
#  include watchdog2_front_dev
#  include xagent_all
#  include pinger_cdn_dev
#}
node /^front-bj-weiyi-\d+/ {
  include puppet_all
  include systembase_front
  include watchdog_front
  include btdaemon_front
  include zabbix_all
  include ats_front
  include nginx_front_source
  include cagent_front
  include rtmp_front

  include cto2_all
  include xagent_all
  include watchdog2_front_source
  include pinger_cdn
  include spider_cdn
  include falcon-agent_all
}
node /^front-tj.*/,/^front-gd-dg-ctc.*/,/^front-hb-lf-cnc-80/ {
#node /^front-zj-jx-shuangxian-\d+/ {
  include puppet_all
  include systembase_front_dev
  include watchdog_front_dev
  include btdaemon_front_dev
  include zabbix_all
  include ats_front_dev
  include nginx_front_dev
  include cagent_front_dev
  include rtmp_front_dev

  include cto2_all
  include watchdog2_front_dev
  include xagent_all
  include pinger_cdn_dev
  include spider_cdn_dev
  include falcon-agent_all
}

#node 'front-tj-bgp-192' {
#  include salt_all
#}

node /^front-.*/ {
  include puppet_all
  include systembase_front
  include watchdog_front
  include btdaemon_front
  include zabbix_all
  include ats_front
  include nginx_front
  include cagent_front
  include rtmp_front

  include cto2_all
  include xagent_all
  include watchdog2_front
  include pinger_cdn
  include spider_cdn
  include falcon-agent_all
#  include salt_all
}
