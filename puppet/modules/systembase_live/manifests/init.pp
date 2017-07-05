class systembase_live{
  include systembase_live::authorized_keys
#  include systembase_live::crond
#  include systembase_live::crtmpserver
  include systembase_live::ffmux
  include systembase_live::hardinfo
  include systembase_live::hostsdenyallow
  include systembase_live::install
  include systembase_live::profile
#  include systembase_live::service_stop
#  include systembase_live::service_start
  include systembase_live::shellupdate
  include systembase_live::smokeping
#  include systembase_live::sudoers
#  include systembase_live::sysctl
  include systembase_live::tmpdir
  include systembase_live::yumrepo
  include systembase_live::ntp_config
  include systembase_live::ntp_service
  include systembase_live::ssh_config
  include systembase_live::ssh_service
  include systembase_live::rsyslog_config
}
