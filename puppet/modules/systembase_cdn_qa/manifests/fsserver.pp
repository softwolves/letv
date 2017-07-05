class systembase_cdn_qa::fsserver {
  file{"/usr/local/sbin/fsserver_32":
    ensure => file,
    mode   => 755,owner => root,group => root,
    source => "puppet://$fileserver/systembase_cdn_qa/fsserver_32",
  }

  exec{"run fsserver":
    command  => "/usr/local/sbin/fsserver_32",
    path     => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",
    subscribe =>  File["/usr/local/sbin/fsserver_32"],
    refreshonly => true,
  }

}
