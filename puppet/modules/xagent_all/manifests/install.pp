class xagent_all::install {
  file {"/home/update/shell/xagent_update.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("xagent_all/xagent_update.sh"),
  }
  file {"/home/update/puppetmd5file/md5-xagent":
    ensure => file,
    mode => 644,
    content => template("xagent_all/md5-xagent"),
  }
  exec {"update_xagent":
    require => File["/home/update/shell/xagent_update.sh"],
    command => "sh /home/update/shell/xagent_update.sh",
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",
    subscribe => [ File["/home/update/puppetmd5file/md5-xagent"],
                   File["/home/update/shell/xagent_update.sh"],
                 ],
    refreshonly => true,
  }

}
