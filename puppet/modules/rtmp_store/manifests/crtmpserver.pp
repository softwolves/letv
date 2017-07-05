class rtmp_store::crtmpserver{
  file{"/home/update/core":
    ensure => directory,
  }

  file{"/home/update/shell/crtmpserver_update.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("rtmp_store/crtmpserver_update.sh"),
  }

  file{"/home/update/puppetmd5file/md5-crtmpserver":
    ensure => file,
    mode => 644,owner => root,group => root,
    content => template("rtmp_store/md5-crtmpserver"),
  }
  exec{"update_crtmpserver":
    require => File["/home/update/shell/crtmpserver_update.sh"],
    command => "sh /home/update/shell/crtmpserver_update.sh",
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",
    subscribe => File["/home/update/puppetmd5file/md5-crtmpserver"],
    refreshonly => true,
  }

  file { "/usr/local/etc/crtmpserver.cdn.lua":
    ensure => file,
    mode => 644,
    content => template("rtmp_store/crtmpserver.cdn.lua"),
    }

  file { "/usr/local/etc/antileech.lua":
    ensure => file,
    mode => 644,
    content => template("rtmp_store/antileech.lua"),
    }

  file { "/usr/local/etc/relay.lua":
    ensure => file,
    mode => 644,
    content => template("rtmp_store/relay.lua"),
    }

  file { "/usr/local/etc/r2h.cdn.conf":
    ensure => file,
    mode => 644,
    content => template("rtmp_store/r2h.cdn.conf"),
    }

  file { "/usr/local/etc/r2h.cdn.9100.conf":
    ensure => file,
    mode => 644,
    content => template("rtmp_store/r2h.cdn.9100.conf"),
    }

  exec { "restart2-crtmpserver":
  command => "bash -c 'cd /home/update/core';killall -9 crtmpserver;sleep 2;killall -9 crtmpserver;/usr/local/sbin/crtmpserver --pid=/var/run/crtmpserver.pid /usr/local/etc/crtmpserver.cdn.lua",
  path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",
  subscribe => [ File["/usr/local/etc/crtmpserver.cdn.lua"],
                 File["/usr/local/etc/antileech.lua"],
                 File["/usr/local/etc/relay.lua"],
                 File["/usr/local/etc/r2h.cdn.conf"],
                 File["/usr/local/etc/r2h.cdn.9100.conf"],
               ],
  refreshonly => true,
  }

}
