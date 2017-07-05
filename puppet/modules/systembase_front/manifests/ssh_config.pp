class systembase_front::ssh_config {

  file { "/etc/ssh/sshd_config":
    mode => 644,
    ensure => file,
    content => template("systembase_front/sshd_config"),
    notify  => Class['systembase_front::ssh_service'],
  }

}
