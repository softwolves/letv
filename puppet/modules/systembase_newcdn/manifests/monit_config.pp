class systembase_newcdn::monit_config {
  file {"/etc/monitrc":
    mode => 700,
    ensure => file,
    content => template("systembase_newcdn/monitrc"),
    notify    => Class['systembase_newcdn::monit_service'],
  }

  file {"/etc/init/monit.conf":
    mode => 644,
    ensure => file,
    content => template("systembase_newcdn/monit.conf"),
    notify    => Class['systembase_newcdn::monit_service'],
  }
}
