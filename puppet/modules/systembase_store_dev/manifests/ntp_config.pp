class systembase_store_dev::ntp_config {
  file {"/etc/ntp.conf":
    mode => 644,
    ensure => file,
    content => template("systembase_store_dev/ntp.conf"),
#    require   => Class['systembase_store_dev::ntp_install'],
#    notify    => Class['systembase_store_dev::ntp_service'],
  }

  file {"/etc/sysconfig/ntpd":
    mode => 644,
    ensure => file,
    content => template("systembase_store_dev/ntpd"),
#    require   => Class['systembase_store_dev::ntp_install'],
#    notify    => Class['systembase_store_dev::ntp_service'],
  }

  file {"/etc/sysconfig/ntpdate":
    mode => 644,
    ensure => file,
    content => template("systembase_store_dev/ntpdate"),
#    require   => Class['systembase_store_dev::ntp_install'],
#    notify    => Class['systembase_store_dev::ntp_service'],
  }
} 
