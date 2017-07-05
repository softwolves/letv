class systembase_cdn_spe::ssh_service {
  service { "sshd":
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,

  }

}
