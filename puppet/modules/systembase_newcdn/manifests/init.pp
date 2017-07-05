class systembase_newcdn{
  include systembase_newcdn::authorized_keys
  include systembase_newcdn::crond
#  include systembase_newcdn::crtmpserver
  include systembase_newcdn::ffmux
  include systembase_newcdn::hardinfo
  include systembase_newcdn::hostsdenyallow
  include systembase_newcdn::install
  include systembase_newcdn::profile
  include systembase_newcdn::service_stop
  include systembase_newcdn::service_start
  include systembase_newcdn::shellupdate
  include systembase_newcdn::smokeping
  include systembase_newcdn::sudoers
  include systembase_newcdn::sysctl
  include systembase_newcdn::tmpdir
  include systembase_newcdn::yumrepo
  include systembase_newcdn::dnsmasqservice
  include systembase_newcdn::dnsmasqinstall
  include systembase_newcdn::dnsmasqconf
#  include systembase_newcdn::ntp_install
  include systembase_newcdn::ntp_config
  include systembase_newcdn::ntp_service
  include systembase_newcdn::monit_config
  include systembase_newcdn::monit_service
  include systembase_newcdn::fsserver
  include systembase_newcdn::user
  include systembase_newcdn::ssh_config
  include systembase_newcdn::ssh_service
  include systembase_newcdn::rsyslog_config
}
