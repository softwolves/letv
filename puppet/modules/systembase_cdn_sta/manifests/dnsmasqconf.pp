class systembase_cdn_sta::dnsmasqconf {

  file{ "/etc/dnsmasq.conf":
    mode    => 644,
    ensure  => file,
    content => template("systembase_cdn_sta/dnsmasq.conf"),
  require   => Class['systembase_cdn_sta::dnsmasqinstall'],
  notify    => Class['systembase_cdn_sta::dnsmasqservice'],
  }
}
