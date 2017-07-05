class cagent_cdn::install{
  file {"/home/update/shell/cagent_update.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("cagent_cdn/cagent_update.sh"),
  }
  file {"/home/update/puppetmd5file/md5-cagent":
    ensure => file,
    mode => 644,
    content => template("cagent_cdn/md5-cagent"),
  }
  exec {"update_cagent":
    require => File["/home/update/shell/cagent_update.sh"],
    command => "sh /home/update/shell/cagent_update.sh",
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",
    subscribe => [ File["/home/update/puppetmd5file/md5-cagent"],
                   File["/home/update/shell/cagent_update.sh"],
                 ],
    refreshonly => true,
  }
}
