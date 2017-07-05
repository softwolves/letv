class systembase_cloud::dnsmasqconf {

  file{ "/etc/dnsmasq.conf":
    mode    => 644,
    ensure  => file,
    content => template("systembase_cloud/dnsmasq.conf"),
  require   => Class['systembase_cloud::dnsmasqinstall'],
  notify    => Class['systembase_cloud::dnsmasqservice'],
  }
}
