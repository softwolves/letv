class systembase_cdn_spe::ntp_config {
  file {"/etc/ntp.conf":
    mode => 644,
    ensure => file,
    content => template("systembase_cdn_spe/ntp.conf"),
#    require   => Class['systembase_cdn_spe::ntp_install'],
    notify    => Class['systembase_cdn_spe::ntp_service'],
  }

  file {"/etc/sysconfig/ntpd":
    mode => 644,
    ensure => file,
    content => template("systembase_cdn_spe/ntpd"),
#    require   => Class['systembase_cdn_spe::ntp_install'],
    notify    => Class['systembase_cdn_spe::ntp_service'],
  }

  file {"/etc/sysconfig/ntpdate":
    mode => 644,
    ensure => file,
    content => template("systembase_cdn_spe/ntpdate"),
#    require   => Class['systembase_cdn_spe::ntp_install'],
#    notify    => Class['systembase_cdn_spe::ntp_service'],
  }
} 
