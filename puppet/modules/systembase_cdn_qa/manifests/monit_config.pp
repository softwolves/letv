class systembase_cdn_qa::monit_config {
  file {"/etc/monitrc":
    mode => 700,
    ensure => file,
    content => template("systembase_cdn_qa/monitrc"),
    notify    => Class['systembase_cdn_qa::monit_service'],
  }

  file {"/etc/init/monit.conf":
    mode => 644,
    ensure => file,
    content => template("systembase_cdn_qa/monit.conf"),
    notify    => Class['systembase_cdn_qa::monit_service'],
  }
}
