class cto2_all::install {
  file {"/home/update/shell/ctod_update.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("cto2_all/ctod_update.sh"),
  }

  file {"/home/update/shell/libstdc_update.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("cto2_all/libstdc_update.sh"),
  }

  file {"/home/update/puppetmd5file/md5-ctod":
    ensure => file,
    mode => 644,
    content => template("cto2_all/md5-ctod"),
  }

  file {"/home/update/puppetmd5file/md5-libstdc":
    ensure => file,
    mode => 644,
    content => template("cto2_all/md5-libstdc"),
  }

  exec {"update ctod":
    path      => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin:/cto/bin",
    command => "bash /home/update/shell/ctod_update.sh",
    subscribe => [ 
                   File["/home/update/puppetmd5file/md5-ctod"],
                 ],
    refreshonly => true,
  }

  exec {"update libstdc":
    path      => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin:/cto/bin",
    command => "bash /home/update/shell/libstdc_update.sh",
    subscribe => [ 
                   File["/home/update/puppetmd5file/md5-libstdc"],
                 ],
    refreshonly => true,
  }

}
