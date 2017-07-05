class btdaemon_cdn_dev::install{

  file {"/home/update/shell/btdaemon_update.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("btdaemon_cdn_dev/btdaemon_update.sh"),
  }

#  file {"/home/update/shell/diamond_update.sh":
#    ensure => file,
#    mode => 755,owner => root,group => root,
#    content => template("btdaemon_cdn_dev/diamond_update.sh"),
#  }

  file {"/home/update/puppetmd5file/md5-btdaemon":
    ensure => file,
    mode => 644,
    content => template("btdaemon_cdn_dev/md5-btdaemon"),
  }

#  file {"/home/update/puppetmd5file/md5-diamond":
#    ensure => file,
#    mode => 644,
#    content => template("btdaemon_cdn_dev/md5-diamond"),
#  }

  exec {"update-btdaemon":
    require => File["/home/update/shell/btdaemon_update.sh"],
    command => "sh /home/update/shell/btdaemon_update.sh",
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",
    subscribe => File["/home/update/puppetmd5file/md5-btdaemon"],
    refreshonly => true,
  }

#  exec {"update-diamond":
#    require => File["/home/update/shell/diamond_update.sh"],
#    command => "sh /home/update/shell/diamond_update.sh",
#    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",
#    subscribe => File["/home/update/puppetmd5file/md5-diamond"],
#    refreshonly => true,
#  }

#  service {"diamond":
#    ensure      =>  running,
#    enable      =>  true,
#    hasrestart  =>  true,
#    hasstatus   =>  true,
#    subscribe   =>  File['/etc/diamond/diamond.conf'],
#  }

#  file {"/etc/diamond/diamond.conf":
#    ensure  => file,
#    mode    => 644,
#    content => template("btdaemon_cdn_dev/diamond.conf"),
#    require => File["/home/update/shell/diamond_update.sh"],
#  }
}
