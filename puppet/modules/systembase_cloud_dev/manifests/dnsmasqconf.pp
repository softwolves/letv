class systembase_cloud_dev::dnsmasqconf {

  file{ "/etc/dnsmasq.conf":
    mode    => 644,
    ensure  => file,
    content => template("systembase_cloud_dev/dnsmasq.conf"),
  require   => Class['systembase_cloud_dev::dnsmasqinstall'],
  notify    => Class['systembase_cloud_dev::dnsmasqservice'],
  }
}
