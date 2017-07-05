class puppet_all::service{
  service{ "puppetd":
#    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    subscribe  => Class["puppet_all::config"],
  }
}
