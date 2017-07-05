class systembase_store::ntp_service {
  service{ "ntpd":
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    subscribe  => Class["systembase_store::ntp_config"],
  }
}
