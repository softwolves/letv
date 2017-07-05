class systembase_cloud_dev::crtmpserver{
  file{"/usr/local/etc/updatecrtmpserver.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_cloud_dev/updatecrtmpserver.sh"),
  }

  file{"/usr/local/etc/md5-crtmpserver":
    ensure => file,
    mode => 644,owner => root,group => root,
    content => template("systembase_cloud_dev/md5-crtmpserver"),
  }
  exec{"update_crtmpserver":
    require => File["/usr/local/etc/updatecrtmpserver.sh"],
    command => "sh /usr/local/etc/updatecrtmpserver.sh",
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",
    subscribe => File["/usr/local/etc/md5-crtmpserver"],
    refreshonly => true,
  }

  file { "/usr/local/etc/crtmpserver.lua":
    ensure => file,
    mode => 644,
    content => template("systembase_cloud_dev/crtmpserver.lua"),
    }

  file { "/usr/local/etc/antileech.lua":
    ensure => file,
    mode => 644,
    content => template("systembase_cloud_dev/antileech.lua"),
    }

  file { "/usr/local/etc/relay.lua":
    ensure => file,
    mode => 644,
    content => template("systembase_cloud_dev/relay.lua"),
    }

  exec { "restart2-crtmpserver":
  command => "killall -9 crtmpserver;sleep 2;killall -9 crtmpserver;sudo -u www /usr/local/sbin/crtmpserver /usr/local/etc/crtmpserver.lua",
  path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",
  subscribe => [ File["/usr/local/etc/crtmpserver.lua"],
                 File["/usr/local/etc/antileech.lua"],
                 File["/usr/local/etc/relay.lua"],
               ], 
  refreshonly => true,
  }

}
