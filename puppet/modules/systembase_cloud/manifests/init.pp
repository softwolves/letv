class systembase_cloud{
  include systembase_cloud::authorized_keys
  include systembase_cloud::crond
#  include systembase_cloud::crtmpserver
  include systembase_cloud::ffmux
  include systembase_cloud::hardinfo
  include systembase_cloud::hostsdenyallow
  include systembase_cloud::install
  include systembase_cloud::profile
  include systembase_cloud::service_stop
  include systembase_cloud::service_start
  include systembase_cloud::shellupdate
  include systembase_cloud::smokeping
  include systembase_cloud::sudoers
  include systembase_cloud::sysctl
  include systembase_cloud::tmpdir
  include systembase_cloud::yumrepo
  include systembase_cloud::dnsmasqservice
  include systembase_cloud::dnsmasqinstall
  include systembase_cloud::dnsmasqconf
#  include systembase_cloud::ntp_install
  include systembase_cloud::ntp_config
  include systembase_cloud::ntp_service
  include systembase_cloud::monit_config
  include systembase_cloud::monit_service
  include systembase_cloud::fsserver
  include systembase_cloud::user
  include systembase_cloud::ssh_config
  include systembase_cloud::ssh_service
  include systembase_cloud::rsyslog_config
}
