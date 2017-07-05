class systembase_cdn_dev::monit_config {
  file {"/etc/monitrc":
    mode => 700,
    ensure => file,
    content => template("systembase_cdn_dev/monitrc"),
    notify    => Class['systembase_cdn_dev::monit_service'],
  }

  file {"/etc/init/monit.conf":
    mode => 644,
    ensure => file,
    content => template("systembase_cdn_dev/monit.conf"),
    notify    => Class['systembase_cdn_dev::monit_service'],
  }
}
