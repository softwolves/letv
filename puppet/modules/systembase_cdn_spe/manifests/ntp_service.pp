class systembase_cdn_spe::ntp_service {
  service{ "ntpd":
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    subscribe  => Class["systembase_cdn_spe::ntp_config"],
  }
}
