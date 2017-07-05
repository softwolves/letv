class watchdog_store_dev::install{
  file{"/home/update":
    ensure => directory,
  }

  file{"/home/update/file":
    ensure => directory,
  }

  file{"/home/update/md5file":
    ensure => directory,
  }

  file{"/home/update/puppetmd5file":
    ensure => directory,
  }

  file{"/home/update/shell":
    ensure => directory,
  }

  file {"/home/update/shell/watchdog_update.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("watchdog_store_dev/watchdog_update.sh"),
  }
 
  file {"/home/update/puppetmd5file/md5-watchdog":
    ensure => file,
    mode => 644,
    content => template("watchdog_store_dev/md5-watchdog"),
  }
  exec {"update-watchdog":
    require => File["/home/update/shell/watchdog_update.sh"],
    command => "sh /home/update/shell/watchdog_update.sh",
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",
    subscribe => File["/home/update/puppetmd5file/md5-watchdog"],
    refreshonly => true,
  }
}
