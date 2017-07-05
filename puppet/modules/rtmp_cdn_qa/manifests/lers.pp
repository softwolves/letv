class rtmp_cdn_qa::lers{
  file{"/home/update/core":
    ensure => directory,
  }

  file{"/home/update/shell/lers_update.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("rtmp_cdn_qa/lers_update.sh"),
  }

  file{"/home/update/puppetmd5file/md5-lers":
    ensure => file,
    mode => 644,owner => root,group => root,
    content => template("rtmp_cdn_qa/md5-lers"),
  }

  file{"/home/update/puppetmd5file/md5-lers_proxy":
    ensure => file,
    mode => 644,owner => root,group => root,
    content => template("rtmp_cdn_qa/md5-lers_proxy"),
  }

  exec{"update_lers":
    require => File["/home/update/shell/lers_update.sh"],
    command => "sh /home/update/shell/lers_update.sh",
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",
    subscribe => File["/home/update/puppetmd5file/md5-lers",
		"/home/update/puppetmd5file/md5-lers_proxy"
    ],
    refreshonly => true,
  }

  file { "/usr/local/etc/antileech.lua":
    ensure => file,
    mode => 644,
    content => template("rtmp_cdn_qa/antileech.lua"),
    }

  file { "/usr/local/etc/relay.lua":
    ensure => file,
    mode => 644,
    content => template("rtmp_cdn_qa/relay.lua"),
    }

  file { "/usr/local/etc/lers.cdn.lua":
    ensure => file,
    mode => 644,
    content => template("rtmp_cdn_qa/lers.cdn.lua"),
    }

  file { "/usr/local/etc/lers_proxy.cdn.conf":
    ensure => file,
    mode => 644,
    content => template("rtmp_cdn_qa/lers_proxy.cdn.conf"),
    }

  exec { "restart2-lers":
  command => "bash -c 'cd /home/update/core';killall -9 crtmpserver rtmp2http;sleep 2;killall -9 crtmpserver rtmp2http;/usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf -s reload;killall -9 lers;/usr/local/sbin/lers  -c /usr/local/etc/lers.cdn.lua",
  path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",
  subscribe => [ File["/usr/local/etc/antileech.lua"],
                 File["/usr/local/etc/relay.lua"],
                 File["/usr/local/etc/lers.cdn.lua"],
                 File["/usr/local/etc/lers_proxy.cdn.conf"],
               ],
  refreshonly => true,
  }

}
