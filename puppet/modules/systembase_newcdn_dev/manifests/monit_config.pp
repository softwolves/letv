class systembase_newcdn_dev::monit_config {
  file {"/etc/monitrc":
    mode => 700,
    ensure => file,
    content => template("systembase_newcdn_dev/monitrc"),
    notify    => Class['systembase_newcdn_dev::monit_service'],
  }

  file {"/etc/init/monit.conf":
    mode => 644,
    ensure => file,
    content => template("systembase_newcdn_dev/monit.conf"),
    notify    => Class['systembase_newcdn_dev::monit_service'],
  }
}
