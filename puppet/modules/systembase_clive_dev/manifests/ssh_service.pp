class systembase_clive_dev::ssh_service {
  service { "sshd":
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,

  }

}
