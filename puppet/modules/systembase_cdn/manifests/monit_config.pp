class systembase_cdn::monit_config {
  file {"/etc/monitrc":
    mode => 700,
    ensure => file,
    content => template("systembase_cdn/monitrc"),
    notify    => Class['systembase_cdn::monit_service'],
  }

  file {"/etc/init/monit.conf":
    mode => 644,
    ensure => file,
    content => template("systembase_cdn/monit.conf"),
    notify    => Class['systembase_cdn::monit_service'],
  }
}
