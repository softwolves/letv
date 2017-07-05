class systembase_store::monit_config {
  file {"/etc/monitrc":
    mode => 700,
    ensure => file,
    content => template("systembase_store/monitrc"),
    notify    => Class['systembase_store::monit_service'],
  }

  file {"/etc/init/monit.conf":
    mode => 644,
    ensure => file,
    content => template("systembase_store/monit.conf"),
    notify    => Class['systembase_store::monit_service'],
  }
}
