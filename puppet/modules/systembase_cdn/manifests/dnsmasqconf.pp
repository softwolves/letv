class systembase_cdn::dnsmasqconf {

  file{ "/etc/dnsmasq.conf":
    mode    => 644,
    ensure  => file,
    content => template("systembase_cdn/dnsmasq.conf"),
  require   => Class['systembase_cdn::dnsmasqinstall'],
  notify    => Class['systembase_cdn::dnsmasqservice'],
  }
}
