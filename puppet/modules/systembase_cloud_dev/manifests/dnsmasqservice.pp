class systembase_cloud_dev::dnsmasqservice{
  service{ "dnsmasq":
    ensure    => running,
    hasstatus => true,
    hasrestart => true,
    enable     => true,
    subscribe  => Class["systembase_cloud_dev::dnsmasqconf"],
    }

}
