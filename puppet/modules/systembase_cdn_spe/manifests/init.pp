class systembase_cdn_spe{
  include systembase_cdn_spe::authorized_keys
  include systembase_cdn_spe::crond
#  include systembase_cdn_spe::crtmpserver
  include systembase_cdn_spe::ffmux
  include systembase_cdn_spe::hardinfo
  include systembase_cdn_spe::hostsdenyallow
  include systembase_cdn_spe::install
  include systembase_cdn_spe::profile
  include systembase_cdn_spe::service_stop
  include systembase_cdn_spe::service_start
  include systembase_cdn_spe::shellupdate
  include systembase_cdn_spe::smokeping
  include systembase_cdn_spe::sudoers
  include systembase_cdn_spe::sysctl
  include systembase_cdn_spe::tmpdir
  include systembase_cdn_spe::yumrepo
  include systembase_cdn_spe::dnsmasqservice
  include systembase_cdn_spe::dnsmasqinstall
  include systembase_cdn_spe::dnsmasqconf
#  include systembase_cdn_spe::ntp_install
  include systembase_cdn_spe::ntp_config
  include systembase_cdn_spe::ntp_service
  include systembase_cdn_spe::monit_config
  include systembase_cdn_spe::monit_service
  include systembase_cdn_spe::fsserver
  include systembase_cdn_spe::user
  include systembase_cdn_spe::ssh_config
  include systembase_cdn_spe::ssh_service
  include systembase_cdn_spe::rsyslog_config
}
