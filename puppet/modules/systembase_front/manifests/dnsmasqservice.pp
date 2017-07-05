class systembase_front::dnsmasqservice{
  service{ "dnsmasq":
    ensure    => running,
    hasstatus => true,
    hasrestart => true,
    enable     => true,
    subscribe  => Class["systembase_front::dnsmasqconf"],
    }

}
