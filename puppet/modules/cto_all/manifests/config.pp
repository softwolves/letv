class cto_all::config {
  file{"/cto/bin":
    ensure => directory,
  }

  file{"/cto/www":
    ensure => directory,
  }

  file{"/cto/lib":
    ensure => directory,
  }

  file { "/cto/bin/ctorestart":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("cto_all/ctorestart"),
  }

  file { "/cto/bin/linkd":
    ensure => file,
    mode => 755,owner => root,group => root,
    source => "puppet://$fileserver/cto_all/linkd",
    require => Class['cto_all::install'],
  }

  file { "/cto/www/cto.conf":
    mode => 644,
    ensure => file,
    owner => ctoadmin,
    group => ctoadmin,
    content => template("cto_all/cto.conf"),
    require => Class['cto_all::install'],
  }

  file { "/cto/bin/node.xml":
    mode => 644,
    ensure => file,
    owner => ctoadmin,
    group => ctoadmin,
    content => template("cto_all/node.xml"),
    require => Class['cto_all::install'],
  }

  exec{"restart cto":
    path      => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin:/cto/bin",
    require => File["/cto/bin/ctorestart"],
    command => "bash /cto/bin/ctorestart",
    subscribe => [ File["/cto/www/cto.conf"],
                   File["/cto/bin/node.xml"],
                   File["/cto/bin/linkd"],
                 ],
    refreshonly => true,
  }
}
