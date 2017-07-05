class systembase_newcdn::monit_service {
  service{ "monit":
    ensure     => running,
    hasstatus  => false,
    hasrestart => false,
    subscribe  => Class["systembase_newcdn::monit_config"],
    start      => "/usr/bin/monit quit; sleep 2; /usr/bin/monit; /usr/bin/monit monitor all",
#    restart    => "/usr/bin/monit reload",
    stop       => "/usr/bin/monit quit",
  }
}
