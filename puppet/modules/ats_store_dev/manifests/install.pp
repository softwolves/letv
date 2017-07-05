class ats_store_dev::install {
  file{"/letv/fet/ats_data":
    ensure => directory,
  }

  file{"/usr/local/sbin/ats":
    ensure => directory,
  }

  file{"/usr/local/letv/ats":
    ensure => directory,
  }

  file{"/var/ats/":
    ensure => directory,
  }

  file{"/var/ats/log/":
    ensure => directory,
  }

  file{"/var/ats/log/trafficserver/":
    ensure => directory,
  }

  file { "/lib/libtcl8.5.so":
    ensure => file,
    mode   => 755,owner => root,group => root,
    source => "puppet://$fileserver/ats_store_dev/libtcl8.5.so"

  }

  file { "/home/update/shell/ats_update.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("ats_store_dev/ats_update.sh"),

  }
  file { "/home/update/puppetmd5file/md5-ats":
    ensure => file,
    mode => 644,
    content => template("ats_store_dev/md5-ats"),
  }

  exec { "update-ats":
    require => File["/home/update/shell/ats_update.sh"],
    command => "/sbin/ldconfig ; sh /home/update/shell/ats_update.sh",
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",
    subscribe => [  File["/home/update/puppetmd5file/md5-ats"],
                    File["/lib/libtcl8.5.so"],
                 ],
    refreshonly => true,

  }
}
