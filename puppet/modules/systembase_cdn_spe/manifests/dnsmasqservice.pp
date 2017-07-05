class systembase_cdn_spe::dnsmasqservice{
  service{ "dnsmasq":
    ensure    => running,
    hasstatus => true,
    hasrestart => true,
    enable     => true,
    subscribe  => Class["systembase_cdn_spe::dnsmasqconf"],
    }

}
