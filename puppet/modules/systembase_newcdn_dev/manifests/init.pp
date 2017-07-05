class systembase_newcdn_dev{
  include systembase_newcdn_dev::authorized_keys
  include systembase_newcdn_dev::crond
#  include systembase_newcdn_dev::crtmpserver
  include systembase_newcdn_dev::ffmux
  include systembase_newcdn_dev::hardinfo
  include systembase_newcdn_dev::hostsdenyallow
  include systembase_newcdn_dev::install
  include systembase_newcdn_dev::profile
  include systembase_newcdn_dev::service_stop
  include systembase_newcdn_dev::service_start
  include systembase_newcdn_dev::shellupdate
  include systembase_newcdn_dev::smokeping
  include systembase_newcdn_dev::sudoers
  include systembase_newcdn_dev::sysctl
  include systembase_newcdn_dev::tmpdir
  include systembase_newcdn_dev::yumrepo
  include systembase_newcdn_dev::dnsmasqservice
  include systembase_newcdn_dev::dnsmasqinstall
  include systembase_newcdn_dev::dnsmasqconf
#  include systembase_newcdn_dev::ntp_install
  include systembase_newcdn_dev::ntp_config
  include systembase_newcdn_dev::ntp_service
  include systembase_newcdn_dev::monit_config
  include systembase_newcdn_dev::monit_service
  include systembase_newcdn_dev::fsserver
  include systembase_newcdn_dev::user
  include systembase_newcdn_dev::ssh_config
  include systembase_newcdn_dev::ssh_service
  include systembase_newcdn_dev::rsyslog_config
}
