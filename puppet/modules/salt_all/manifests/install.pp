class salt_all::install{
  file {"/letv/soft/nginx/saltinstall.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("salt_all/saltinstall.sh"),

  }

  file {"/letv/soft/nginx/md5-salt":
    ensure => file,
    mode => 644,
    content => template("salt_all/md5-salt"),
  }

  exec {"install salt-minion":
    path    => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",
    command => "bash /letv/soft/nginx/saltinstall.sh",
    subscribe => File["/letv/soft/nginx/md5-salt"],
    require => File["/letv/soft/nginx/saltinstall.sh"],
    refreshonly => true,
#    creates => "/etc/salt/minion",
  }

}
