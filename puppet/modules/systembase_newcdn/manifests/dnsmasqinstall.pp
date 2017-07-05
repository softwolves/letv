class systembase_newcdn::dnsmasqinstall{
  package{ 'dnsmasq':
#    ensure => latest,
    ensure   => present,
    provider => rpm,
    source   => "http://115.182.94.72/puppet/package/dnsmasq-2.71-1.x86_64.rpm",
  }
}
