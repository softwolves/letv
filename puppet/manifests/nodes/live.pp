node serverliveqa {
  include puppet_all
  include systembase_clive_dev
  include watchdog_live
  include btdaemon_live
  include zabbix_all
  include nginx_clive_dev
  include cagent_live

  include cto2_all
  include xagent_all
  include pinger_cdn_dev
  include spider_cdn_dev
}

#node /live-hb-lf-cnc-test-81/,/^live-bj-bj-dxt-letv-\d+/,/live-bj-bj-dxt-tiyu-\d+/,/^live-bj-bj-dxt-weishi-\d+/,/^live-bj-bj-dxt-tiyu1-\d+/,/^live-bj-bj-dxt-weishi1-\d+/,/^live-bj-bj-dxt-weishi2-\d+/,/^live-js-yz-cnc-weishi-\d+/,/^live-js-yz-cnc-tiyu-\d+/,/^live-js-yz-cnc-tiyu1-\d+/,/^live-js-yz-cnc-letv-\d+/,/^live-tj-tj-ctc-weishi-\d+/,/^live-tj-tj-ctc-tiyu-\d+/,/^live-tj-tj-ctc-letv-\d+/,/^live-tj-tj-ctc-tiyu1-\d+/,/^live-tj-tj-ctc-weishi1-\d+/,/^live-tj-tj-ctc-weishi2-\d+/ {
#node /live-hb-lf-cnc-test-81/,/^live-bj-bj-dxt-weishi-\d+/,/^live-bj-bj-dxt-tiyu1-\d+/,/^live-bj-bj-dxt-weishi1-\d+/,/^live-bj-bj-dxt-weishi2-\d+/,/^live-js-yz-cnc-weishi-\d+/,/^live-js-yz-cnc-tiyu-\d+/,/^live-js-yz-cnc-tiyu1-\d+/,/^live-js-yz-cnc-letv-\d+/,/^live-tj-tj-ctc-weishi-\d+/,/^live-tj-tj-ctc-tiyu-\d+/,/^live-tj-tj-ctc-letv-\d+/,/^live-tj-tj-ctc-tiyu1-\d+/,/^live-tj-tj-ctc-weishi1-\d+/,/^live-tj-tj-ctc-weishi2-\d+/,/live-bj-hp-bgp-clive-\d+/ {

# live测试点 485 224 288 285 (288 285 为多次匹配)
node /live-hb-lf-cnc-test-81/,/^live-bj-bj-dxt-weishi-\d+/,/^live-bj-bj-dxt-tiyu1-\d+/,/^live-bj-bj-dxt-weishi1-\d+/,/^live-bj-bj-dxt-weishi2-\d+/,/^live-js-yz-cnc-weishi-\d+/,/^live-js-yz-cnc-tiyu-\d+/,/^live-js-yz-cnc-tiyu1-\d+/,/^live-js-yz-cnc-letv-\d+/,/^live-tj-tj-ctc-weishi-\d+/,/^live-tj-tj-ctc-tiyu-\d+/,/^live-tj-tj-ctc-letv-\d+/,/^live-tj-tj-ctc-tiyu1-\d+/,/^live-tj-tj-ctc-weishi1-\d+/,/^live-tj-tj-ctc-weishi2-\d+/ {
#node /^live-zj-hz-cnc-weishi-\d+/ {
  include puppet_all
  include systembase_live_dev
  include watchdog_live_dev
  include btdaemon_live_dev
  include zabbix_all
  include nginx_live_dev
  include cagent_live_dev

  include cto2_all_dev
  include pinger_cdn_dev
  include xagent_all
  include spider_cdn_dev
}

# clive 469 479 257 281 439 美国点 50004 504 499 50011 
node /live-bj-bj-hp-cloud-\d+/,/live-js-nj-ctc-clive-\d+/,/live-gd-dg-ctc-clive-\d+/,/live-bj-tdxy-bgp-clive-\d+/,/^live-bj-hp-bgp-clive-\d+/,/^live-us-la-clive-113/,/^live-us-la-clive-114/,/live-bj-wy-bgp-cloud-\d+/,/live-bj-bj-nw-clive-120/,/live-bj-tdxy2-bgp-clive-\d+/,/live-bj-tdxy3-bgp-clive-\d+/,/live-bj-bj-tdxy-clive-70/ {
  include puppet_all
  include systembase_clive
  include watchdog_live
  include btdaemon_live
  include zabbix_all
  include nginx_clive
  include cagent_live

  include cto2_all
  include xagent_all
  include pinger_cdn
  include spider_cdn
}

# clive测试点 403 437 438 (其中438为多次匹配) 466 (cloud,clive2次匹配) 283
node /^live-sx-xa-ctc-clive-\d+/,/^live-bj-hp-cloud-test-\d+/,/live-zj-ls-sx-letv-\d+/,/live-zj-ls-sx-weishi-\d+/,/live-zj-ls-sx-tiyu-\d+/,/^live-zj-ls-sx-clive-\d+/,/^live-zj-ls-sx-cloud-\d+/,/^live-sx-xy-cnc-clive-\d+/ {
  include puppet_all
  include systembase_clive_dev
  include watchdog_live
  include btdaemon_live
  include zabbix_all
  include nginx_clive_dev
  include cagent_live

  include cto2_all
  include xagent_all
  include pinger_cdn_dev
  include spider_cdn_dev
}

node /^live-bj-bj-dxt-letv-\d+/ {
#node /^live-bj-bj-dxt-letv-\d+/,/live-bj-bj-dxt-tiyu-\d+/ {
#node /^live-.*-ctc-letv-*/ {
#node /^live-.*-letv-*/,/^live-.*-weishi*/ {
  include puppet_all
  include systembase_live
  include watchdog_live
  include btdaemon_live
  include zabbix_all
  include nginx_live
  include cagent_live

  include cto2_all
  include xagent_all
  include pinger_cdn
  include spider_cdn
}


######所有live服务器##########
node /^live-*/ {
  include puppet_all
  include systembase_live
  include watchdog_live
  include btdaemon_live
  include zabbix_all
  include nginx_live
  include cagent_live

  include cto2_all
  include xagent_all
  include pinger_cdn
  include spider_cdn
}
