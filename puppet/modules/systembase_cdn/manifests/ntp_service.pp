class systembase_cdn::ntp_service {
  service{ "ntpd":
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    subscribe  => Class["systembase_cdn::ntp_config"],
  }
}
