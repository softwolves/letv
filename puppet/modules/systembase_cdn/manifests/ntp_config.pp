class systembase_cdn::ntp_config {
  file {"/etc/ntp.conf":
    mode => 644,
    ensure => file,
    content => template("systembase_cdn/ntp.conf"),
#    require   => Class['systembase_cdn::ntp_install'],
    notify    => Class['systembase_cdn::ntp_service'],
  }

  file {"/etc/sysconfig/ntpd":
    mode => 644,
    ensure => file,
    content => template("systembase_cdn/ntpd"),
#    require   => Class['systembase_cdn::ntp_install'],
    notify    => Class['systembase_cdn::ntp_service'],
  }

  file {"/etc/sysconfig/ntpdate":
    mode => 644,
    ensure => file,
    content => template("systembase_cdn/ntpdate"),
#    require   => Class['systembase_cdn::ntp_install'],
#    notify    => Class['systembase_cdn::ntp_service'],
  }
} 
