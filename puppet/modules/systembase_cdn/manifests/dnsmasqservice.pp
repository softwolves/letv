class systembase_cdn::dnsmasqservice{
  service{ "dnsmasq":
    ensure    => running,
    hasstatus => true,
    hasrestart => true,
    enable     => true,
    subscribe  => Class["systembase_cdn::dnsmasqconf"],
    }

}
