class systembase_store::ntp_config {
  file {"/etc/ntp.conf":
    mode => 644,
    ensure => file,
    content => template("systembase_store/ntp.conf"),
#    require   => Class['systembase_store::ntp_install'],
#    notify    => Class['systembase_store::ntp_service'],
  }

  file {"/etc/sysconfig/ntpd":
    mode => 644,
    ensure => file,
    content => template("systembase_store/ntpd"),
#    require   => Class['systembase_store::ntp_install'],
#    notify    => Class['systembase_store::ntp_service'],
  }

  file {"/etc/sysconfig/ntpdate":
    mode => 644,
    ensure => file,
    content => template("systembase_store/ntpdate"),
#    require   => Class['systembase_store::ntp_install'],
#    notify    => Class['systembase_store::ntp_service'],
  }
} 
