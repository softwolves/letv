class watchdog2_cdn_dev::install{
  file{"/etc/watchdog2/":
    ensure => directory,
  }

  file{"/etc/watchdog2/watchdog.json":
    ensure => file,
    mode => 644,owner => root,group => root,
    content => template("watchdog2_cdn_dev/watchdog.json"),
  }


  file{"/etc/init.d/watchdog2":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("watchdog2_cdn_dev/watchdog2"),
  }

  exec {"restart-watchdog2":
    command => "/etc/init.d/watchdog2 restart",
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",
    subscribe => File["/etc/watchdog2/watchdog.json"],
    refreshonly => true,
  }


  file {"/home/update/shell/watchdog2_update.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("watchdog2_cdn_dev/watchdog2_update.sh"),
  }

  file {"/home/update/puppetmd5file/md5-watchdog2":
    ensure => file,
    mode => 644,
    content => template("watchdog2_cdn_dev/md5-watchdog2"),
  }
  exec {"update-watchdog2":
    require => File["/home/update/shell/watchdog2_update.sh"],
    command => "sh /home/update/shell/watchdog2_update.sh",
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",
    subscribe => File["/home/update/puppetmd5file/md5-watchdog2"],
    refreshonly => true,
  }
}
