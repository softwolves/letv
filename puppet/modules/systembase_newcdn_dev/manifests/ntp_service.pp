class systembase_newcdn_dev::ntp_service {
  service{ "ntpd":
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    subscribe  => Class["systembase_newcdn_dev::ntp_config"],
  }
}
