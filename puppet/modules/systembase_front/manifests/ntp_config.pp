class systembase_front::ntp_config {
  file {"/etc/ntp.conf":
    mode => 644,
    ensure => file,
    content => template("systembase_front/ntp.conf"),
#    require   => Class['systembase_front::ntp_install'],
#    notify    => Class['systembase_front::ntp_service'],
  }

  file {"/etc/sysconfig/ntpd":
    mode => 644,
    ensure => file,
    content => template("systembase_front/ntpd"),
#    require   => Class['systembase_front::ntp_install'],
#    notify    => Class['systembase_front::ntp_service'],
  }

  file {"/etc/sysconfig/ntpdate":
    mode => 644,
    ensure => file,
    content => template("systembase_front/ntpdate"),
#    require   => Class['systembase_front::ntp_install'],
#    notify    => Class['systembase_front::ntp_service'],
  }
} 
