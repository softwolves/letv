class systembase_front::dnsmasqconf {

  file{ "/etc/dnsmasq.conf":
    mode    => 644,
    ensure  => file,
    content => template("systembase_front/dnsmasq.conf"),
  require   => Class['systembase_front::dnsmasqinstall'],
  notify    => Class['systembase_front::dnsmasqservice'],
  }
}
