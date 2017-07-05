class systembase_clive::ssh_config {

  file { "/etc/ssh/sshd_config":
    mode => 644,
    ensure => file,
    content => template("systembase_clive/sshd_config"),
    notify  => Class['systembase_clive::ssh_service'],
  }

}
