class systembase_store_dev::dnsmasqconf {

  file{ "/etc/dnsmasq.conf":
    mode    => 644,
    ensure  => file,
    content => template("systembase_store_dev/dnsmasq.conf"),
  require   => Class['systembase_store_dev::dnsmasqinstall'],
  notify    => Class['systembase_store_dev::dnsmasqservice'],
  }
}
