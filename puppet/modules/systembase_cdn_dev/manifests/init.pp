class systembase_cdn_dev{
  include systembase_cdn_dev::authorized_keys
  include systembase_cdn_dev::crond
#  include systembase_cdn_dev::lers
  include systembase_cdn_dev::ffmux
  include systembase_cdn_dev::hardinfo
  include systembase_cdn_dev::hostsdenyallow
  include systembase_cdn_dev::install
  include systembase_cdn_dev::profile
  include systembase_cdn_dev::service_stop
  include systembase_cdn_dev::service_start
  include systembase_cdn_dev::shellupdate
  include systembase_cdn_dev::smokeping
  include systembase_cdn_dev::sudoers
  include systembase_cdn_dev::sysctl
  include systembase_cdn_dev::tmpdir
  include systembase_cdn_dev::yumrepo
  include systembase_cdn_dev::dnsmasqservice
  include systembase_cdn_dev::dnsmasqinstall
  include systembase_cdn_dev::dnsmasqconf
#  include systembase_cdn_dev::ntp_install
  include systembase_cdn_dev::ntp_config
  include systembase_cdn_dev::ntp_service
  include systembase_cdn_dev::monit_config
  include systembase_cdn_dev::monit_service
  include systembase_cdn_dev::fsserver
  include systembase_cdn_dev::user
  include systembase_cdn_dev::ssh_config
  include systembase_cdn_dev::ssh_service
  include systembase_cdn_dev::rsyslog_config
}
