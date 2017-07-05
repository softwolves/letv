class systembase_live::ntp_config {
  file {"/etc/ntp.conf":
    mode => 644,
    ensure => file,
    content => template("systembase_live/ntp.conf"),
#    require   => Class['systembase_live::ntp_install'],
#    notify    => Class['systembase_live::ntp_service'],
  }

  file {"/etc/sysconfig/ntpd":
    mode => 644,
    ensure => file,
    content => template("systembase_live/ntpd"),
#    require   => Class['systembase_live::ntp_install'],
#    notify    => Class['systembase_live::ntp_service'],
  }

  file {"/etc/sysconfig/ntpdate":
    mode => 644,
    ensure => file,
    content => template("systembase_live/ntpdate"),
#    require   => Class['systembase_live::ntp_install'],
#    notify    => Class['systembase_live::ntp_service'],
  }
} 
