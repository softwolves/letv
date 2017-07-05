class systembase_newcdn_dev::dnsmasqconf {

  file{ "/etc/dnsmasq.conf":
    mode    => 644,
    ensure  => file,
    content => template("systembase_newcdn_dev/dnsmasq.conf"),
  require   => Class['systembase_newcdn_dev::dnsmasqinstall'],
  notify    => Class['systembase_newcdn_dev::dnsmasqservice'],
  }
}
