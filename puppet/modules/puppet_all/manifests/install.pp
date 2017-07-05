class puppet_all::install{
  package{"puppet":
    ensure   => present,
    provider => rpm,
    source   => "http://115.182.94.72/puppet/package/puppet-2.6.11-3.x86_64.rpm",
  }
  package{"facter":
    ensure   => present,
    provider => rpm,
    source   => "http://115.182.94.72/puppet/package/facter-1.6.0-1.x86_64.rpm",
  }
}
