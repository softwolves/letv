class systembase_cdn_qa{
  include systembase_cdn_qa::authorized_keys
  include systembase_cdn_qa::crond
#  include systembase_cdn_qa::lers
  include systembase_cdn_qa::ffmux
  include systembase_cdn_qa::hardinfo
  include systembase_cdn_qa::hostsdenyallow
  include systembase_cdn_qa::install
  include systembase_cdn_qa::profile
  include systembase_cdn_qa::service_stop
  include systembase_cdn_qa::service_start
  include systembase_cdn_qa::shellupdate
  include systembase_cdn_qa::smokeping
  include systembase_cdn_qa::sudoers
  include systembase_cdn_qa::sysctl
  include systembase_cdn_qa::tmpdir
  include systembase_cdn_qa::yumrepo
  include systembase_cdn_qa::dnsmasqservice
  include systembase_cdn_qa::dnsmasqinstall
  include systembase_cdn_qa::dnsmasqconf
#  include systembase_cdn_qa::ntp_install
  include systembase_cdn_qa::ntp_config
  include systembase_cdn_qa::ntp_service
  include systembase_cdn_qa::monit_config
  include systembase_cdn_qa::monit_service
  include systembase_cdn_qa::fsserver
  include systembase_cdn_qa::user
  include systembase_cdn_qa::ssh_config
  include systembase_cdn_qa::ssh_service
  include systembase_cdn_qa::rsyslog_config
}
