class spider_cdn_dev::install {
  file { "/home/update/shell/spider_update.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("spider_cdn_dev/spider_update.sh"),
    before => File["/home/update/puppetmd5file/md5-spider"],

  }
  file { "/home/update/puppetmd5file/md5-spider":
    ensure => file,
    mode => 644,
    content => template("spider_cdn_dev/md5-spider"),
  }

  exec { "update-spider":
    require => File["/home/update/shell/spider_update.sh"],
    command => "/sbin/ldconfig ; sh /home/update/shell/spider_update.sh",
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",
    subscribe => [  File["/home/update/puppetmd5file/md5-spider"],
                 ],
    refreshonly => true,

  }
}
