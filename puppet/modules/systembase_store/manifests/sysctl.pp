class systembase_store::sysctl{
  file{"/etc/security/limits.d/letv.conf":
    ensure => file,
    mode   => 644,
    content => template("systembase_store/letv.conf"),
  }

  file{"/etc/sysctl.conf":
    ensure => file,
    mode   => 644,
    content => template("systembase_store/sysctl.conf"),
  }

  file{"/etc/sysctl.d/letv.conf":
    ensure => absent,
  }

  exec{"/sbin/sysctl -p /etc/sysctl.conf":
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",
    subscribe => [ File["/etc/sysctl.conf"],
                   File["/etc/sysctl.d/letv.conf"],
                 ],
    refreshonly => true,
  }
}
