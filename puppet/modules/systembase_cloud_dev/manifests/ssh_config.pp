class systembase_cloud_dev::ssh_config {

  file { "/etc/ssh/sshd_config":
    mode => 644,
    ensure => file,
    content => template("systembase_cloud_dev/sshd_config"),
    notify  => Class['systembase_cloud_dev::ssh_service'],
  }

}
