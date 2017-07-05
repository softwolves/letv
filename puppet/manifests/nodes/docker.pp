node /container-.*/ {
  include puppet_all
  include systembase_live
  include watchdog_live
  include zabbix_all
  include nginx_live
  include cagent_live

#  include puppet_all
#  include systembase_live
#  include watchdog_live
#  include zabbix_all
#  include nginx_live
}
