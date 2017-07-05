class systembase_cdn_sta::rsyslog_config {

#  file { "/etc/rsyslog.conf":
#    ensure => file,
#    mode => 644,
#    content => template("systembase_cdn_sta/rsyslog.conf"),
#    notify  => Class['systembase_cdn_sta::rsyslog_service'],
#  }

#  file { "/etc/logrotate.d/syslog":
#    ensure => file,
#    mode => 644,
#    content => template("systembase_cdn_sta/syslog"),
#  }

  file{"/var/log/secure":
    mode => 644,
  }

}
