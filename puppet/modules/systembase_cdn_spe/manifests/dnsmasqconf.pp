class systembase_cdn_spe::dnsmasqconf {

  file{ "/etc/dnsmasq.conf":
    mode    => 644,
    ensure  => file,
    content => template("systembase_cdn_spe/dnsmasq.conf"),
  require   => Class['systembase_cdn_spe::dnsmasqinstall'],
  notify    => Class['systembase_cdn_spe::dnsmasqservice'],
  }
}
