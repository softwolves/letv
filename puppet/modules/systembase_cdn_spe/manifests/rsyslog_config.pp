class systembase_cdn_spe::rsyslog_config {

#  file { "/etc/rsyslog.conf":
#    ensure => file,
#    mode => 644,
#    content => template("systembase_cdn_spe/rsyslog.conf"),
#    notify  => Class['systembase_cdn_spe::rsyslog_service'],
#  }

#  file { "/etc/logrotate.d/syslog":
#    ensure => file,
#    mode => 644,
#    content => template("systembase_cdn_spe/syslog"),
#  }

  file{"/var/log/secure":
    mode => 644,
  }

}
