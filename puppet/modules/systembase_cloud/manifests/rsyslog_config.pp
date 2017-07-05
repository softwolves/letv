class systembase_cloud::rsyslog_config {

#  file { "/etc/rsyslog.conf":
#    ensure => file,
#    mode => 644,
#    content => template("systembase_cloud/rsyslog.conf"),
#    notify  => Class['systembase_cloud::rsyslog_service'],
#  }

#  file { "/etc/logrotate.d/syslog":
#    ensure => file,
#    mode => 644,
#    content => template("systembase_cloud/syslog"),
#  }

  file{"/var/log/secure":
    mode => 644,
  }

}
