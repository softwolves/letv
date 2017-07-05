####nginx config file###
class nginx_cdn_impo::config {
  file{"/usr/local/nginx":
    ensure => directory,
  }

  file{"/usr/local/nginx/conf":
    ensure => directory,
  }

  file{"/usr/local/nginx/logs":
    ensure => directory,
  }

  file{"/usr/local/nginx/sbin":
    ensure => directory,
  }

  file{"/usr/local/nginx/html":
    ensure => directory,
  }

  file{"/usr/local/nginx/conf/lua":
    ensure => directory,
  }

  file{"/usr/local/nginx/conf/lualib/":
    ensure => directory,
  }

  file{"/usr/local/nginx/conf/lualib/resty/":
    ensure => directory,
  }

  file{"/usr/local/nginx/conf/lualib/socket/":
    ensure => directory,
  }

  file{"/usr/local/nginx/conf/lualib/net/":
    ensure => directory,
  }

  file{"/usr/local/nginx/conf/domains":
    ensure => directory,
  }

  file{"/usr/local/nginx/conf/letv":
    ensure => directory,
  }

  file{"/usr/local/nginx/conf/vhosts":
    ensure => directory,
  }

  file{"/usr/local/nginx/conf/win-utf":
    ensure => file,
    mode   => 644,
    content => template("nginx_cdn_impo/win-utf"),
  }

  file{"/usr/local/nginx/conf/fastcgi.conf":
    ensure => file,
    mode   => 644,
    content => template("nginx_cdn_impo/fastcgi.conf"),
  }

  file{"/usr/local/nginx/conf/scgi_params":
    ensure => file,
    mode   => 644,
    content => template("nginx_cdn_impo/scgi_params"),
  }

  file{"/usr/local/nginx/conf/nginx.conf":
    ensure => file,
    mode   => 644,
    content => template("nginx_cdn_impo/nginx.conf"),
  }

  file{"/usr/local/nginx/conf/mime.types":
    ensure => file,
    mode   => 644,
    content => template("nginx_cdn_impo/mime.types"),
  }

  file{"/usr/local/nginx/conf/uwsgi_params":
    ensure => file,
    mode   => 644,
    content => template("nginx_cdn_impo/uwsgi_params"),
  }

  file{"/usr/local/nginx/conf/fastcgi_params":
    ensure => file,
    mode   => 644,
    content => template("nginx_cdn_impo/fastcgi_params"),
  }

  file{"/usr/local/nginx/conf/koi-win":
    ensure => file,
    mode   => 644,
    content => template("nginx_cdn_impo/koi-win"),
  }

  file{"/usr/local/nginx/conf/koi-utf":
    ensure => file,
    mode   => 644,
    content => template("nginx_cdn_impo/koi-utf"),
  }


  file{"/usr/local/nginx/html/50x.html":
    ensure => file,
    mode   => 644,
    content => template("nginx_cdn_impo/50x.html"),
  }

  file{"/usr/local/nginx/html/index.html":
    ensure => file,
    mode   => 644,
    content => template("nginx_cdn_impo/index.html"),
  }

#####################lua#######################

  file{"/usr/local/nginx/conf/lua/imgo.lua":
    ensure => file,
    mode   => 644,
    content => template("nginx_cdn_impo/imgo.lua"),
  }

  file{"/usr/local/nginx/conf/lua/m3u8_fetch.lua":
    ensure => file,
    mode   => 644,
    content => template("nginx_cdn_impo/m3u8_fetch.lua"),
  }
#################vhosts#######

  file{"/usr/local/nginx/conf/vhosts/distribute.conf":
    ensure => file,
    mode   => 644,
    content => template("nginx_cdn_impo/distribute.conf"),
  }

  file{"/usr/local/nginx/conf/vhosts/imgo.conf":
    ensure => file,
    mode   => 644,
    content => template("nginx_cdn_impo/imgo.conf"),
  }

#################lualib#######
  file{"/usr/local/nginx/conf/lualib/cjson.so":
    ensure => file,
    mode   => 644,
    source => "puppet://$fileserver/nginx_cdn_impo/cjson.so",
  }

  file{"/usr/local/nginx/conf/lualib/socket.lua":
    ensure => file,
    mode   => 644,
    content => template("nginx_cdn_impo/socket.lua"),
  }

################resty###########
  file{"/usr/local/nginx/conf/lualib/resty/http.lua":
    ensure => file,
    mode   => 644,
    content => template("nginx_cdn_impo/http.lua"),
  }

  file{"/usr/local/nginx/conf/lualib/resty/http_headers.lua":
    ensure => file,
    mode   => 644,
    content => template("nginx_cdn_impo/http_headers.lua"),
  }
##############socket########
  file{"/usr/local/nginx/conf/lualib/socket/core.so":
    ensure => file,
    mode   => 644,
    source => "puppet://$fileserver/nginx_cdn_impo/core.so",
  }

###############net########
  file{"/usr/local/nginx/conf/lualib/net/url.lua":
    ensure => file,
    mode   => 644,
    content => template("nginx_cdn_impo/url.lua"),
  }

#  exec{"/usr/local/sbin/nginx -c /usr/local/etc/nginx.conf -s reload":
  exec{"/usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf -s reload":
    path      => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",
    subscribe => [  File["/usr/local/nginx/conf/win-utf"],
                    File["/usr/local/nginx/conf/scgi_params"],
                    File["/usr/local/nginx/conf/fastcgi.conf"],
                    File["/usr/local/nginx/conf/nginx.conf"],
                    File["/usr/local/nginx/conf/mime.types"],
                    File["/usr/local/nginx/conf/uwsgi_params"],
                    File["/usr/local/nginx/conf/fastcgi_params"],
                    File["/usr/local/nginx/conf/koi-win"],
                    File["/usr/local/nginx/conf/koi-utf"],
                    File["/usr/local/nginx/conf/lua/imgo.lua"],
                    File["/usr/local/nginx/conf/lua/m3u8_fetch.lua"],
                    File["/usr/local/nginx/html/50x.html"],
                    File["/usr/local/nginx/html/index.html"],
                    File["/usr/local/nginx/conf/lualib/cjson.so"],
                    File["/usr/local/nginx/conf/lualib/socket.lua"],
                    File["/usr/local/nginx/conf/lualib/resty/http.lua"],
                    File["/usr/local/nginx/conf/lualib/resty/http_headers.lua"],
                    File["/usr/local/nginx/conf/lualib/socket/core.so"],
                    File["/usr/local/nginx/conf/lualib/net/url.lua"],
                    File["/usr/local/nginx/conf/vhosts/distribute.conf"],
                    File["/usr/local/nginx/conf/vhosts/imgo.conf"],
                 ],
      onlyif      => '/usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf -t',
      refreshonly => true,
  }
}
