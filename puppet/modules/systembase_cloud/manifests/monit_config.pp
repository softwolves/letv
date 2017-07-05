class systembase_cloud::monit_config {
  file {"/etc/monitrc":
    mode => 700,
    ensure => file,
    content => template("systembase_cloud/monitrc"),
    notify    => Class['systembase_cloud::monit_service'],
  }

  file {"/etc/init/monit.conf":
    mode => 644,
    ensure => file,
    content => template("systembase_cloud/monit.conf"),
    notify    => Class['systembase_cloud::monit_service'],
  }
}
