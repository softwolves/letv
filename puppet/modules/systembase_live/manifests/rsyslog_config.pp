class systembase_live::rsyslog_config {

#  file { "/etc/rsyslog.conf":
#    ensure => file,
#    mode => 644,
#    content => template("systembase_live/rsyslog.conf"),
#    notify  => Class['systembase_live::rsyslog_service'],
#  }

#  file { "/etc/logrotate.d/syslog":
#    ensure => file,
#    mode => 644,
#    content => template("systembase_live/syslog"),
#  }

  file{"/var/log/secure":
    mode => 644,
  }

}
