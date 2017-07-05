class systembase_newcdn::rsyslog_config {

#  file { "/etc/rsyslog.conf":
#    ensure => file,
#    mode => 644,
#    content => template("systembase_newcdn/rsyslog.conf"),
#    notify  => Class['systembase_newcdn::rsyslog_service'],
#  }

#  file { "/etc/logrotate.d/syslog":
#    ensure => file,
#    mode => 644,
#    content => template("systembase_newcdn/syslog"),
#  }

  file{"/var/log/secure":
    mode => 644,
  }

}
