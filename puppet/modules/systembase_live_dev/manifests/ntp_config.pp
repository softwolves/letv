class systembase_live_dev::ntp_config {
  file {"/etc/ntp.conf":
    mode => 644,
    ensure => file,
    content => template("systembase_live_dev/ntp.conf"),
#    require   => Class['systembase_live_dev::ntp_install'],
#    notify    => Class['systembase_live_dev::ntp_service'],
  }

  file {"/etc/sysconfig/ntpd":
    mode => 644,
    ensure => file,
    content => template("systembase_live_dev/ntpd"),
#    require   => Class['systembase_live_dev::ntp_install'],
#    notify    => Class['systembase_live_dev::ntp_service'],
  }

  file {"/etc/sysconfig/ntpdate":
    mode => 644,
    ensure => file,
    content => template("systembase_live_dev/ntpdate"),
#    require   => Class['systembase_live_dev::ntp_install'],
#    notify    => Class['systembase_live_dev::ntp_service'],
  }
} 
