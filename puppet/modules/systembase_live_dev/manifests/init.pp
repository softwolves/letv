class systembase_live_dev{
  include systembase_live_dev::authorized_keys
#  include systembase_live_dev::crond
#  include systembase_live_dev::lers
  include systembase_live_dev::ffmux
  include systembase_live_dev::hardinfo
  include systembase_live_dev::hostsdenyallow
  include systembase_live_dev::install
  include systembase_live_dev::profile
#  include systembase_live_dev::service_stop
#  include systembase_live_dev::service_start
  include systembase_live_dev::shellupdate
  include systembase_live_dev::smokeping
#  include systembase_live_dev::sudoers
#  include systembase_live_dev::sysctl
  include systembase_live_dev::tmpdir
  include systembase_live_dev::yumrepo
  include systembase_live_dev::ntp_config
  include systembase_live_dev::ntp_service
  include systembase_live_dev::ssh_config
  include systembase_live_dev::ssh_service
  include systembase_live_dev::rsyslog_config
}
