class systembase_cdn_spe::ssh_config {

  file { "/etc/ssh/sshd_config":
    mode => 644,
    ensure => file,
    content => template("systembase_cdn_spe/sshd_config"),
    notify  => Class['systembase_cdn_spe::ssh_service'],
  }

}
