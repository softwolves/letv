class systembase_newcdn_dev::ntp_config {
  file {"/etc/ntp.conf":
    mode => 644,
    ensure => file,
    content => template("systembase_newcdn_dev/ntp.conf"),
#    require   => Class['systembase_newcdn_dev::ntp_install'],
    notify    => Class['systembase_newcdn_dev::ntp_service'],
  }

  file {"/etc/sysconfig/ntpd":
    mode => 644,
    ensure => file,
    content => template("systembase_newcdn_dev/ntpd"),
#    require   => Class['systembase_newcdn_dev::ntp_install'],
    notify    => Class['systembase_newcdn_dev::ntp_service'],
  }

  file {"/etc/sysconfig/ntpdate":
    mode => 644,
    ensure => file,
    content => template("systembase_newcdn_dev/ntpdate"),
#    require   => Class['systembase_newcdn_dev::ntp_install'],
#    notify    => Class['systembase_newcdn_dev::ntp_service'],
  }
} 
