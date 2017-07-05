class systembase_cdn_qa::ntp_config {
  file {"/etc/ntp.conf":
    mode => 644,
    ensure => file,
    content => template("systembase_cdn_qa/ntp.conf"),
#    require   => Class['systembase_cdn_qa::ntp_install'],
    notify    => Class['systembase_cdn_qa::ntp_service'],
  }

  file {"/etc/sysconfig/ntpd":
    mode => 644,
    ensure => file,
    content => template("systembase_cdn_qa/ntpd"),
#    require   => Class['systembase_cdn_qa::ntp_install'],
    notify    => Class['systembase_cdn_qa::ntp_service'],
  }

  file {"/etc/sysconfig/ntpdate":
    mode => 644,
    ensure => file,
    content => template("systembase_cdn_qa/ntpdate"),
#    require   => Class['systembase_cdn_qa::ntp_install'],
#    notify    => Class['systembase_cdn_qa::ntp_service'],
  }
} 
