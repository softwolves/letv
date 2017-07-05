class systembase_cloud::sysctl{
  file{"/etc/security/limits.d/letv.conf":
    ensure => file,
    mode   => 644,
    content => template("systembase_cloud/letv.conf"),
  }

  file{"/etc/sysctl.conf":
    ensure => file,
    mode   => 644,
    content => template("systembase_cloud/sysctl.conf"),
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

  exec{"echo never > /sys/kernel/mm/transparent_hugepage/enabled":
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",
    onlyif => "grep never$ /sys/kernel/mm/transparent_hugepage/enabled"
  }

  exec{"echo never > /sys/kernel/mm/transparent_hugepage/defrag":
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",
    onlyif => "grep never$ /sys/kernel/mm/transparent_hugepage/defrag"
  }

  exec{"echo never > /sys/kernel/mm/redhat_transparent_hugepage/enabled":
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",
    onlyif => "grep never$ /sys/kernel/mm/redhat_transparent_hugepage/enabled"
  }

  exec{"echo never > /sys/kernel/mm/redhat_transparent_hugepage/defrag":
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",
    onlyif => "grep never$  /sys/kernel/mm/redhat_transparent_hugepage/defrag"
  }

}
