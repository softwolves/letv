class systembase_cdn_qa::ssh_config {

  file { "/etc/ssh/sshd_config":
    mode => 644,
    ensure => file,
    content => template("systembase_cdn_qa/sshd_config"),
    notify  => Class['systembase_cdn_qa::ssh_service'],
  }

}
