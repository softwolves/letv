class systembase_cdn_sta::ntp_config {
  file {"/etc/ntp.conf":
    mode => 644,
    ensure => file,
    content => template("systembase_cdn_sta/ntp.conf"),
#    require   => Class['systembase_cdn_sta::ntp_install'],
    notify    => Class['systembase_cdn_sta::ntp_service'],
  }

  file {"/etc/sysconfig/ntpd":
    mode => 644,
    ensure => file,
    content => template("systembase_cdn_sta/ntpd"),
#    require   => Class['systembase_cdn_sta::ntp_install'],
    notify    => Class['systembase_cdn_sta::ntp_service'],
  }

  file {"/etc/sysconfig/ntpdate":
    mode => 644,
    ensure => file,
    content => template("systembase_cdn_sta/ntpdate"),
#    require   => Class['systembase_cdn_sta::ntp_install'],
#    notify    => Class['systembase_cdn_sta::ntp_service'],
  }
} 
