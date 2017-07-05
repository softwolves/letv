class systembase_newcdn::ssh_config {

  file { "/etc/ssh/sshd_config":
    mode => 644,
    ensure => file,
    content => template("systembase_newcdn/sshd_config"),
    notify  => Class['systembase_newcdn::ssh_service'],
  }

}
