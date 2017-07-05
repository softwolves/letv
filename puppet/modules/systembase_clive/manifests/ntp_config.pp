class systembase_clive::ntp_config {
  file {"/etc/ntp.conf":
    mode => 644,
    ensure => file,
    content => template("systembase_clive/ntp.conf"),
#    require   => Class['systembase_clive::ntp_install'],
#    notify    => Class['systembase_clive::ntp_service'],
  }

  file {"/etc/sysconfig/ntpd":
    mode => 644,
    ensure => file,
    content => template("systembase_clive/ntpd"),
#    require   => Class['systembase_clive::ntp_install'],
#    notify    => Class['systembase_clive::ntp_service'],
  }

  file {"/etc/sysconfig/ntpdate":
    mode => 644,
    ensure => file,
    content => template("systembase_clive/ntpdate"),
#    require   => Class['systembase_clive::ntp_install'],
#    notify    => Class['systembase_clive::ntp_service'],
  }
} 
