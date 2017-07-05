class systembase_clive{
  include systembase_clive::authorized_keys
#  include systembase_clive::crond
  include systembase_clive::ffmux
  include systembase_clive::hardinfo
  include systembase_clive::hostsdenyallow
  include systembase_clive::install
  include systembase_clive::profile
#  include systembase_clive::service_stop
#  include systembase_clive::service_start
  include systembase_clive::shellupdate
  include systembase_clive::smokeping
#  include systembase_clive::sudoers
#  include systembase_clive::sysctl
  include systembase_clive::tmpdir
  include systembase_clive::yumrepo
  include systembase_clive::ntp_config
  include systembase_clive::ntp_service
  include systembase_clive::ssh_config
  include systembase_clive::ssh_service
  include systembase_clive::rsyslog_config
}
