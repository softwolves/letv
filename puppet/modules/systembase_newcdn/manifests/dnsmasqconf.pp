class systembase_newcdn::dnsmasqconf {

  file{ "/etc/dnsmasq.conf":
    mode    => 644,
    ensure  => file,
    content => template("systembase_newcdn/dnsmasq.conf"),
  require   => Class['systembase_newcdn::dnsmasqinstall'],
  notify    => Class['systembase_newcdn::dnsmasqservice'],
  }
}
