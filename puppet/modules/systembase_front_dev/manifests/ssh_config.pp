class systembase_front_dev::ssh_config {

  file { "/etc/ssh/sshd_config":
    mode => 644,
    ensure => file,
    content => template("systembase_front_dev/sshd_config"),
    notify  => Class['systembase_front_dev::ssh_service'],
  }

}
