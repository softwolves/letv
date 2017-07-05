class systembase_cdn::rsyslog_config {

#  file { "/etc/rsyslog.conf":
#    ensure => file,
#    mode => 644,
#    content => template("systembase_cdn/rsyslog.conf"),
#    notify  => Class['systembase_cdn::rsyslog_service'],
#  }

#  file { "/etc/logrotate.d/syslog":
#    ensure => file,
#    mode => 644,
#    content => template("systembase_cdn/syslog"),
#  }

  file{"/var/log/secure":
    mode => 644,
  }

}
