class btdaemon_store::install{

  file {"/home/update/shell/btdaemon_update.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("btdaemon_store/btdaemon_update.sh"),
  }

  file {"/home/update/puppetmd5file/md5-btdaemon":
    ensure => file,
    mode => 644,
    content => template("btdaemon_store/md5-btdaemon"),
  }
  exec {"update-btdaemon":
    require => File["/home/update/shell/btdaemon_update.sh"],
    command => "sh /home/update/shell/btdaemon_update.sh",
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",
    subscribe => File["/home/update/puppetmd5file/md5-btdaemon"],
    refreshonly => true,
  }

  package {"diamond":
    ensure  =>  absent,
  }

}
