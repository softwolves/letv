class systembase_cloud::ntp_config {
  file {"/etc/ntp.conf":
    mode => 644,
    ensure => file,
    content => template("systembase_cloud/ntp.conf"),
#    require   => Class['systembase_cloud::ntp_install'],
    notify    => Class['systembase_cloud::ntp_service'],
  }

  file {"/etc/sysconfig/ntpd":
    mode => 644,
    ensure => file,
    content => template("systembase_cloud/ntpd"),
#    require   => Class['systembase_cloud::ntp_install'],
    notify    => Class['systembase_cloud::ntp_service'],
  }

  file {"/etc/sysconfig/ntpdate":
    mode => 644,
    ensure => file,
    content => template("systembase_cloud/ntpdate"),
#    require   => Class['systembase_cloud::ntp_install'],
#    notify    => Class['systembase_cloud::ntp_service'],
  }
} 
