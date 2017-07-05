class slice2http_cdn::install{

  file {"/home/update/shell/slice2http_update.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("slice2http_cdn/slice2http_update.sh"),
  }
 
  file {"/home/update/puppetmd5file/md5-slice2http":
    ensure => file,
    mode => 644,
    content => template("slice2http_cdn/md5-slice2http"),
  }
  exec {"update-slice2http":
    require => File["/home/update/shell/slice2http_update.sh"],
    command => "sh /home/update/shell/slice2http_update.sh",
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",
    subscribe => File["/home/update/puppetmd5file/md5-slice2http"],
    refreshonly => true,
  }
}
