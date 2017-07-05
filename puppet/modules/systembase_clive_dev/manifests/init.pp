class systembase_clive_dev{
  include systembase_clive_dev::authorized_keys
#  include systembase_clive_dev::crond
  include systembase_clive_dev::ffmux
  include systembase_clive_dev::hardinfo
  include systembase_clive_dev::hostsdenyallow
  include systembase_clive_dev::install
  include systembase_clive_dev::profile
#  include systembase_clive_dev::service_stop
#  include systembase_clive_dev::service_start
  include systembase_clive_dev::shellupdate
  include systembase_clive_dev::smokeping
#  include systembase_clive_dev::sudoers
#  include systembase_clive_dev::sysctl
  include systembase_clive_dev::tmpdir
  include systembase_clive_dev::yumrepo
  include systembase_clive_dev::ntp_config
  include systembase_clive_dev::ntp_service
  include systembase_clive_dev::ssh_config
  include systembase_clive_dev::ssh_service
  include systembase_clive_dev::rsyslog_config
}
