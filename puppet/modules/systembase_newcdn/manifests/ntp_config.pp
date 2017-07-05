class systembase_newcdn::ntp_config {
  file {"/etc/ntp.conf":
    mode => 644,
    ensure => file,
    content => template("systembase_newcdn/ntp.conf"),
#    require   => Class['systembase_newcdn::ntp_install'],
    notify    => Class['systembase_newcdn::ntp_service'],
  }

  file {"/etc/sysconfig/ntpd":
    mode => 644,
    ensure => file,
    content => template("systembase_newcdn/ntpd"),
#    require   => Class['systembase_newcdn::ntp_install'],
    notify    => Class['systembase_newcdn::ntp_service'],
  }

  file {"/etc/sysconfig/ntpdate":
    mode => 644,
    ensure => file,
    content => template("systembase_newcdn/ntpdate"),
#    require   => Class['systembase_newcdn::ntp_install'],
#    notify    => Class['systembase_newcdn::ntp_service'],
  }
} 
