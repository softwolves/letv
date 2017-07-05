class systembase_store::ssh_config {

  file { "/etc/ssh/sshd_config":
    mode => 644,
    ensure => file,
    content => template("systembase_store/sshd_config"),
    notify  => Class['systembase_store::ssh_service'],
  }

}
