#node 'cdn-sd-qd-ctc-4' {
#
#  include puppet_all
#  include systembase_test
#  include watchdog_cdn
#  include zabbix_all
#  include nginx_cdn
#  include nginx_cdn_four
#}
#node 'front-tj-bgp-192' {
#  include salt_all
#
#}
