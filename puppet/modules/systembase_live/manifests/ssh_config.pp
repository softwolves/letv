class systembase_live::ssh_config {

  file { "/etc/ssh/sshd_config":
    mode => 644,
    ensure => file,
    content => template("systembase_live/sshd_config"),
    notify  => Class['systembase_live::ssh_service'],
  }

}
