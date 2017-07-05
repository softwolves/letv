class puppet_all::config{
  file {"/etc/init.d/puppetd":
    mode => 755,owner => root,group => root,
    content => template("puppet_all/puppetd"),
  }

  file {"/etc/puppet/puppet.conf":
    mode => 644,
    ensure => file,
    content => template("puppet_all/puppet.conf"),
    require => Class['puppet_all::install'],
    notify  => Class['puppet_all::service'],
  }

  file {"/etc/puppet/auth.conf":
    mode => 644,
    ensure => file,
    content => template("puppet_all/auth.conf"),
  }
}
