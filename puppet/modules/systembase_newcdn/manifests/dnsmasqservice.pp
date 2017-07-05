class systembase_newcdn::dnsmasqservice{
  service{ "dnsmasq":
    ensure    => running,
    hasstatus => true,
    hasrestart => true,
    enable     => true,
    subscribe  => Class["systembase_newcdn::dnsmasqconf"],
    }

}
