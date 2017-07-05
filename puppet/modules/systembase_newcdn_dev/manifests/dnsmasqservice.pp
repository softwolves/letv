class systembase_newcdn_dev::dnsmasqservice{
  service{ "dnsmasq":
    ensure    => running,
    hasstatus => true,
    hasrestart => true,
    enable     => true,
    subscribe  => Class["systembase_newcdn_dev::dnsmasqconf"],
    }

}
