class systembase_cdn::ssh_config {

  file { "/etc/ssh/sshd_config":
    mode => 644,
    ensure => file,
    content => template("systembase_cdn/sshd_config"),
    notify  => Class['systembase_cdn::ssh_service'],
  }

}
