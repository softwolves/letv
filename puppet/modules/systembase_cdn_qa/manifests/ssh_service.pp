class systembase_cdn_qa::ssh_service {
  service { "sshd":
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,

  }

}
