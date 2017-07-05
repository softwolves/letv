class systembase_clive_dev::ffmux{
  file{"/lib/libffmux.so.0":
    ensure => file,
    mode   => 755,owner => root,group => root,
    source => "puppet://$fileserver/systembase_clive_dev/libffmux.so.0",
  }

  file{"/lib/libffmux.so":
    ensure => link,
    target => "/lib/libffmux.so.0",
  }
  exec { "update-libffmux":
#    command     => "killall -9 nginx;killall -9 nginx;ldconfig;/usr/local/sbin/nginx -c /usr/local/etc/nginx.conf",
    command     => "ldconfig;/usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf -s reload",
    path        => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",
    subscribe   => File["/lib/libffmux.so.0"],
    onlyif      => '/usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf -t',
    refreshonly => true,
  }

  file{"/lib/libudtp.so.0":
    ensure => file,
    mode   => 755,owner => root,group => root,
    source => "puppet://$fileserver/systembase_clive_dev/libudtp.so.0",
  }

  file{"/lib/libjson.so.0":
    ensure => file,
    mode   => 755,owner => root,group => root,
    source => "puppet://$fileserver/systembase_clive_dev/libjson.so.0",
  }

  file{"/lib/libudtp.so":
    ensure => link,
    target => "/lib/libudtp.so.0",
  }

  file{"/lib/libevent-2.0.so.5":
    ensure => file,
    mode   => 755,owner => root,group => root,
    source => "puppet://$fileserver/systembase_clive_dev/libevent-2.0.so.5",
  }

  file{"/lib/libxml2.so.2":
    ensure => file,
    mode   => 755,owner => root,group => root,
    source => "puppet://$fileserver/systembase_clive_dev/libxml2.so.2",
  }

  exec{"kaoldconfig":
    command => "/sbin/ldconfig",
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",
    subscribe => [  File["/lib/libudtp.so.0"],
                    File["/lib/libevent-2.0.so.5"],
                    File["/lib/libxml2.so.2"],
                    File["/lib/libjson.so.0"],
                 ],
    refreshonly => true,

  }



}
