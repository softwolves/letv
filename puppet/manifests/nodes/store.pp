#node /store-hb-lf-cnc-82/,/^store-qd-cnc-\d+/,/^store-sd-qd-cnc-\d+/,/^store-wh-ctc-\d+/,/^store-hb-hs-ctc-\d+/ {
#node /^store-nj-fh-ctc-.*/,/^store-hb-qhd.*/,/^store-hb-hs-ctc.*/,/^store-wh-ctc.*/,/^store-sd-qd-cnc.*/,/^store-qd-cnc.*/ {
#  include puppet_all
#  include systembase_store_new
#  include watchdog_store_dev
#  include btdaemon_store_dev
#  include zabbix_all
#  include ats_store_dev
#  include nginx_store_new
#  include cagent_store_dev
#  include rtmp_store_dev

#  include cto2_all
#  include watchdog2_store_dev
#  include xagent_all
#  include pinger_cdn_dev
#}

node /^store-sd-qd-cnc-\d+/,/^store-hb-lf-cnc-82/ {
  include puppet_all
  include systembase_store_dev
  include watchdog_store_dev
  include btdaemon_store_dev
  include zabbix_all
  include ats_store_dev
  include nginx_store_dev
  include cagent_store_dev
  include rtmp_store_dev

  include cto2_all
  include watchdog2_store_dev
  include xagent_all
  include pinger_cdn_dev
  include spider_cdn_dev
  include falcon-agent_all
#  include salt_all
}
#

#######所有storage服务器##########
node /^store-.*/ {
  include puppet_all
  include systembase_store
  include watchdog_store
  include btdaemon_store
  include zabbix_all
  include ats_store
  include nginx_store
  include cagent_store
  include rtmp_store

  include cto2_all
  include xagent_all
  include watchdog2_store
  include pinger_cdn
  include spider_cdn
  include falcon-agent_all
#  include salt_all
}
