class systembase_cloud_dev::monit_config {
  file {"/etc/monitrc":
    mode => 700,
    ensure => file,
    content => template("systembase_cloud_dev/monitrc"),
    notify    => Class['systembase_cloud_dev::monit_service'],
  }

  file {"/etc/init/monit.conf":
    mode => 644,
    ensure => file,
    content => template("systembase_cloud_dev/monit.conf"),
    notify    => Class['systembase_cloud_dev::monit_service'],
  }
}
