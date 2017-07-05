class systembase_cdn_sta{
  include systembase_cdn_sta::authorized_keys
  include systembase_cdn_sta::crond
#  include systembase_cdn_sta::lers
  include systembase_cdn_sta::ffmux
  include systembase_cdn_sta::hardinfo
  include systembase_cdn_sta::hostsdenyallow
  include systembase_cdn_sta::install
  include systembase_cdn_sta::profile
  include systembase_cdn_sta::service_stop
  include systembase_cdn_sta::service_start
  include systembase_cdn_sta::shellupdate
  include systembase_cdn_sta::smokeping
  include systembase_cdn_sta::sudoers
  include systembase_cdn_sta::sysctl
  include systembase_cdn_sta::tmpdir
  include systembase_cdn_sta::yumrepo
  include systembase_cdn_sta::dnsmasqservice
  include systembase_cdn_sta::dnsmasqinstall
  include systembase_cdn_sta::dnsmasqconf
#  include systembase_cdn_sta::ntp_install
  include systembase_cdn_sta::ntp_config
  include systembase_cdn_sta::ntp_service
  include systembase_cdn_sta::monit_config
  include systembase_cdn_sta::monit_service
  include systembase_cdn_sta::fsserver
  include systembase_cdn_sta::user
  include systembase_cdn_sta::ssh_config
  include systembase_cdn_sta::ssh_service
  include systembase_cdn_sta::rsyslog_config
}
