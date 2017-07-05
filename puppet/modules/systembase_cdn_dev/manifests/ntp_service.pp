class systembase_cdn_dev::ntp_service {
  service{ "ntpd":
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    subscribe  => Class["systembase_cdn_dev::ntp_config"],
  }
}
