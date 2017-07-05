class systembase_cdn{
  include systembase_cdn::authorized_keys
  include systembase_cdn::crond
#  include systembase_cdn::lers
  include systembase_cdn::ffmux
  include systembase_cdn::hardinfo
  include systembase_cdn::hostsdenyallow
  include systembase_cdn::install
  include systembase_cdn::profile
  include systembase_cdn::service_stop
  include systembase_cdn::service_start
  include systembase_cdn::shellupdate
  include systembase_cdn::smokeping
  include systembase_cdn::sudoers
  include systembase_cdn::sysctl
  include systembase_cdn::tmpdir
  include systembase_cdn::yumrepo
  include systembase_cdn::dnsmasqservice
  include systembase_cdn::dnsmasqinstall
  include systembase_cdn::dnsmasqconf
#  include systembase_cdn::ntp_install
  include systembase_cdn::ntp_config
  include systembase_cdn::ntp_service
  include systembase_cdn::monit_config
  include systembase_cdn::monit_service
  include systembase_cdn::fsserver
  include systembase_cdn::user
  include systembase_cdn::ssh_config
  include systembase_cdn::ssh_service
  include systembase_cdn::rsyslog_config
}
