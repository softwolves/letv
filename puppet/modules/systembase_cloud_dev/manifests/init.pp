class systembase_cloud_dev{
  include systembase_cloud_dev::authorized_keys
  include systembase_cloud_dev::crond
#  include systembase_cloud_dev::crtmpserver
  include systembase_cloud_dev::ffmux
  include systembase_cloud_dev::hardinfo
  include systembase_cloud_dev::hostsdenyallow
  include systembase_cloud_dev::install
  include systembase_cloud_dev::profile
  include systembase_cloud_dev::service_stop
  include systembase_cloud_dev::service_start
  include systembase_cloud_dev::shellupdate
  include systembase_cloud_dev::smokeping
  include systembase_cloud_dev::sudoers
  include systembase_cloud_dev::sysctl
  include systembase_cloud_dev::tmpdir
  include systembase_cloud_dev::yumrepo
  include systembase_cloud_dev::dnsmasqservice
  include systembase_cloud_dev::dnsmasqinstall
  include systembase_cloud_dev::dnsmasqconf
#  include systembase_cloud_dev::ntp_install
  include systembase_cloud_dev::ntp_config
  include systembase_cloud_dev::ntp_service
  include systembase_cloud_dev::monit_config
  include systembase_cloud_dev::monit_service
  include systembase_cloud_dev::fsserver
  include systembase_cloud_dev::user
  include systembase_cloud_dev::ssh_config
  include systembase_cloud_dev::ssh_service
  include systembase_cloud_dev::rsyslog_config
}
