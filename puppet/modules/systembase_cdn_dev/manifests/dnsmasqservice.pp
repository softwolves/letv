class systembase_cdn_dev::dnsmasqservice{
  service{ "dnsmasq":
    ensure    => running,
    hasstatus => true,
    hasrestart => true,
    enable     => true,
    subscribe  => Class["systembase_cdn_dev::dnsmasqconf"],
    }

}
