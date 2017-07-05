class systembase_front_dev::dnsmasqconf {

  file{ "/etc/dnsmasq.conf":
    mode    => 644,
    ensure  => file,
    content => template("systembase_front_dev/dnsmasq.conf"),
  require   => Class['systembase_front_dev::dnsmasqinstall'],
  notify    => Class['systembase_front_dev::dnsmasqservice'],
  }
}
