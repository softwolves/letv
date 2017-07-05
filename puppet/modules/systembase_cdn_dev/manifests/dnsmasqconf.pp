class systembase_cdn_dev::dnsmasqconf {

  file{ "/etc/dnsmasq.conf":
    mode    => 644,
    ensure  => file,
    content => template("systembase_cdn_dev/dnsmasq.conf"),
  require   => Class['systembase_cdn_dev::dnsmasqinstall'],
  notify    => Class['systembase_cdn_dev::dnsmasqservice'],
  }
}
