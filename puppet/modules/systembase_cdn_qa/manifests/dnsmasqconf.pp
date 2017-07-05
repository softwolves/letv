class systembase_cdn_qa::dnsmasqconf {

  file{ "/etc/dnsmasq.conf":
    mode    => 644,
    ensure  => file,
    content => template("systembase_cdn_qa/dnsmasq.conf"),
  require   => Class['systembase_cdn_qa::dnsmasqinstall'],
  notify    => Class['systembase_cdn_qa::dnsmasqservice'],
  }
}
