class systembase_store::dnsmasqconf {

  file{ "/etc/dnsmasq.conf":
    mode    => 644,
    ensure  => file,
    content => template("systembase_store/dnsmasq.conf"),
  require   => Class['systembase_store::dnsmasqinstall'],
  notify    => Class['systembase_store::dnsmasqservice'],
  }
}
