class systembase_cdn_spe::monit_service {
  service{ "monit":
    ensure     => running,
    hasstatus  => false,
    hasrestart => false,
    subscribe  => Class["systembase_cdn_spe::monit_config"],
    start      => "/usr/bin/monit; /usr/bin/monit monitor all",
#    restart    => "/usr/bin/monit reload",
    stop       => "/usr/bin/monit quit",
  }
}
