class systembase_store::rsyslog_config {

#  file { "/etc/rsyslog.conf":
#    ensure => file,
#    mode => 644,
#    content => template("systembase_store/rsyslog.conf"),
#    notify  => Class['systembase_store::rsyslog_service'],
#  }

#  file { "/etc/logrotate.d/syslog":
#    ensure => file,
#    mode => 644,
#    content => template("systembase_store/syslog"),
#  }

  file{"/var/log/secure":
    mode => 644,
  }

}
