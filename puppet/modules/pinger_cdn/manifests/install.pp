class pinger_cdn::install{
  file {"/letv/fet/greenping/": ensure => directory, }
  file {"/home/update/shell/pinger_update.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("pinger_cdn/pinger_update.sh"),
  }
 
  file {"/home/update/puppetmd5file/md5-pinger":
    ensure => file,
    mode => 644,
    content => template("pinger_cdn/md5-pinger"),
  }
  exec {"update-pinger":
    require => File["/home/update/shell/pinger_update.sh"],
    command => "sh /home/update/shell/pinger_update.sh",
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",
    subscribe => File["/home/update/puppetmd5file/md5-pinger"],
    refreshonly => true,
  }
}
