####nginx config file###
class nginx_live_dev::config {
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

#  file{"/usr/local/nginx/html":
#    ensure => directory,
#  }

  file{"/usr/local/nginx/conf/lua":
    ensure => directory,
  }

#  file{"/usr/local/nginx/conf/domains":
#    ensure => directory,
#  }

  file{"/usr/local/nginx/conf/letv":
    ensure => directory,
  }

  file{"/usr/local/nginx/conf/lualib/resty":
    ensure => directory,
  }

  file{"/usr/local/nginx/conf/lualib":
    ensure => directory,
  }

  file{"/usr/local/nginx/conf/win-utf":
    ensure => file,
    mode   => 644,
    content => template("nginx_live_dev/win-utf"),
  }

  file{"/usr/local/nginx/conf/scgi_params":
    ensure => file,
    mode   => 644,
    content => template("nginx_live_dev/scgi_params"),
  }

  file{"/usr/local/nginx/conf/fastcgi.conf":
    ensure => file,
    mode   => 644,
    content => template("nginx_live_dev/fastcgi.conf"),
  }

  file{"/usr/local/nginx/conf/nginx.conf":
    ensure => file,
    mode   => 644,
    content => template("nginx_live_dev/nginx.conf"),
  }

  file{"/usr/local/nginx/conf/mime.types":
    ensure => file,
    mode   => 644,
    content => template("nginx_live_dev/mime.types"),
  }

  file{"/usr/local/nginx/conf/uwsgi_params":
    ensure => file,
    mode   => 644,
    content => template("nginx_live_dev/uwsgi_params"),
  }

  file{"/usr/local/nginx/conf/fastcgi_params":
    ensure => file,
    mode   => 644,
    content => template("nginx_live_dev/fastcgi_params"),
  }

  file{"/usr/local/nginx/conf/koi-win":
    ensure => file,
    mode   => 644,
    content => template("nginx_live_dev/koi-win"),
  }

  file{"/usr/local/nginx/conf/koi-utf":
    ensure => file,
    mode   => 644,
    content => template("nginx_live_dev/koi-utf"),
  }

####################lua########################
  file{"/usr/local/nginx/conf/lua/init_worker.lua":
    ensure => file,
    mode   => 644,
    content => template("nginx_live_dev/init_worker.lua"),
  }

  file{"/usr/local/nginx/conf/lua/local_ips.lua":
    ensure => file,
    mode   => 644,
    content => template("nginx_live_dev/local_ips.lua"),
  }

  file{"/usr/local/nginx/conf/lua/rtmp_connection.lua":
    ensure => file,
    mode   => 644,
    content => template("nginx_live_dev/rtmp_connection.lua"),
  }

  file{"/usr/local/nginx/conf/lua/limit_test.lua":
    ensure => file,
    mode   => 644,
    content => template("nginx_live_dev/limit_test.lua"),
  }

#  file{"/usr/local/nginx/conf/lua/proxy.lua":
#    ensure => file,
#    mode   => 644,
#    content => template("nginx_live_dev/proxy.lua"),
#  }

  file{"/usr/local/nginx/conf/lua/snmpband.lua":
    ensure => file,
    mode   => 644,
    content => template("nginx_live_dev/snmpband.lua"),
  }

  file{"/usr/local/nginx/conf/lua/live_xml.lua":
    ensure => file,
    mode   => 644,
    content => template("nginx_live_dev/live_xml.lua"),
  }
  file{"/usr/local/nginx/conf/lua/hls_creater.lua":
    ensure => file,
    mode   => 644,
    content => template("nginx_live_dev/hls_creater.lua"),
  }

####################letv#######################


  file{"/usr/local/nginx/conf/letv/letv_cto.conf":
    ensure => file,
    mode   => 644,
    content => template("nginx_live_dev/letv_cto.conf"),
  }

  file{"/usr/local/nginx/conf/letv/live.conf":
    ensure => file,
    mode   => 644,
    content => template("nginx_live_dev/live.conf"),
  }

  file{"/usr/local/nginx/conf/lualib/resty/http_headers.lua":
    ensure => file,
    mode   => 644,
    content => template("nginx_live_dev/http_headers.lua"),
  }

  file{"/usr/local/nginx/conf/lualib/resty/http.lua":
    ensure => file,
    mode   => 644,
    content => template("nginx_live_dev/http.lua"),
  }

#  file{"/usr/local/nginx/conf/letv/":
#    ensure => file,
#    mode   => 644,
#    content => template("nginx_live_dev/"),
#  }

#  file{"/usr/local/nginx/html/":
#    ensure => file,
#    mode   => 644,
#    content => template("nginx_live_dev/"),
#  }


#  exec{"/usr/local/sbin/nginx -c /usr/local/etc/nginx.conf -s reload":
#  exec{"/usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf -s reload":
  exec{"echo `ps -ef | grep '/usr/local/nginx/sbin/nginx'|grep 'nginx: master process' | grep -v grep  | awk '{print \$2}'` > /usr/local/nginx/logs/nginx.pid;/usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf -s reload":
    path      => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",

    subscribe => [  
                    File["/usr/local/nginx/conf/win-utf"],
                    File["/usr/local/nginx/conf/scgi_params"],
                    File["/usr/local/nginx/conf/fastcgi.conf"],
                    File["/usr/local/nginx/conf/nginx.conf"],
                    File["/usr/local/nginx/conf/mime.types"],
                    File["/usr/local/nginx/conf/uwsgi_params"],
                    File["/usr/local/nginx/conf/fastcgi_params"],
                    File["/usr/local/nginx/conf/koi-win"],
                    File["/usr/local/nginx/conf/koi-utf"],
                    File["/usr/local/nginx/conf/lua/init_worker.lua"],
                    File["/usr/local/nginx/conf/lua/local_ips.lua"],
                    File["/usr/local/nginx/conf/lua/rtmp_connection.lua"],
                    File["/usr/local/nginx/conf/lua/limit_test.lua"],
#                    File["/usr/local/nginx/conf/lua/proxy.lua"],
                    File["/usr/local/nginx/conf/lua/snmpband.lua"],
                    File["/usr/local/nginx/conf/letv/letv_cto.conf"],
                    File["/usr/local/nginx/conf/lua/live_xml.lua"],
                    File["/usr/local/nginx/conf/lua/hls_creater.lua"],
                    File["/usr/local/nginx/conf/letv/live.conf"],
                    File["/usr/local/nginx/conf/lualib/resty/http_headers.lua"],
                    File["/usr/local/nginx/conf/lualib/resty/http.lua"],
                 ],
      onlyif      => '/usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf -t',
      refreshonly => true,
  }
}
