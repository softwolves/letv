class systembase_newcdn::ntp_service {
  service{ "ntpd":
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    subscribe  => Class["systembase_newcdn::ntp_config"],
  }
}
