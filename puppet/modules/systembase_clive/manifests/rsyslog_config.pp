class systembase_clive::rsyslog_config {

#  file { "/etc/rsyslog.conf":
#    ensure => file,
#    mode => 644,
#    content => template("systembase_clive/rsyslog.conf"),
#    notify  => Class['systembase_clive::rsyslog_service'],
#  }

#  file { "/etc/logrotate.d/syslog":
#    ensure => file,
#    mode => 644,
#    content => template("systembase_clive/syslog"),
#  }

  file{"/var/log/secure":
    mode => 644,
  }

}
