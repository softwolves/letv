class salt_all::service{
  service{ "salt-minion":
#    ensure     => running,
    ensure     => stop,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    subscribe  => Class["salt_all::config"],
  }  
}
