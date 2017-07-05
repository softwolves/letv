class systembase_cloud::ssh_config {

  file { "/etc/ssh/sshd_config":
    mode => 644,
    ensure => file,
    content => template("systembase_cloud/sshd_config"),
    notify  => Class['systembase_cloud::ssh_service'],
  }

}
