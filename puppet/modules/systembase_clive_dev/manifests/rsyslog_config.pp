class systembase_clive_dev::rsyslog_config {

#  file { "/etc/rsyslog.conf":
#    ensure => file,
#    mode => 644,
#    content => template("systembase_clive_dev/rsyslog.conf"),
#    notify  => Class['systembase_clive_dev::rsyslog_service'],
#  }

#  file { "/etc/logrotate.d/syslog":
#    ensure => file,
#    mode => 644,
#    content => template("systembase_clive_dev/syslog"),
#  }

  file{"/var/log/secure":
    mode => 644,
  }

}
