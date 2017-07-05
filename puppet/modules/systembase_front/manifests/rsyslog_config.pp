class systembase_front::rsyslog_config {

#  file { "/etc/rsyslog.conf":
#    ensure => file,
#    mode => 644,
#    content => template("systembase_front/rsyslog.conf"),
#    notify  => Class['systembase_front::rsyslog_service'],
#  }

#  file { "/etc/logrotate.d/syslog":
#    ensure => file,
#    mode => 644,
#    content => template("systembase_front/syslog"),
#  }

  file{"/var/log/secure":
    mode => 644,
  }

}
