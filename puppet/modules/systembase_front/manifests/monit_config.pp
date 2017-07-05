class systembase_front::monit_config {
  file {"/etc/monitrc":
    mode => 700,
    ensure => file,
    content => template("systembase_front/monitrc"),
    notify    => Class['systembase_front::monit_service'],
  }

  file {"/etc/init/monit.conf":
    mode => 644,
    ensure => file,
    content => template("systembase_front/monit.conf"),
    notify    => Class['systembase_front::monit_service'],
  }
}
