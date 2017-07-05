##
class openresty_cdn_qa::config {

  file{"/usr/local/openresty/nginx/conf/lua":
    ensure => directory,
  }

  file{"/usr/local/openresty/nginx/conf/nginx.conf":
    ensure => file,
    mode   => 644,
    content => template("openresty_cdn_qa/nginx.conf"),
  }

  file{"/usr/local/openresty/nginx/conf/lua/get_black_list.lua":
    ensure => file,
    mode   => 644,
    content => template("openresty_cdn_qa/get_black_list.lua"),
  }

  file{"/usr/local/openresty/nginx/conf/lua/token_verify.lua":
    ensure => file,
    mode   => 644,
    content => template("openresty_cdn_qa/token_verify.lua"),
  }

  exec {"restart openresty":
    path      => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",
    command    => "killall -9 openresty ; /usr/local/openresty/nginx/sbin/openresty -c /usr/local/openresty/nginx/conf/nginx.conf",
    subscribe => [ File["/usr/local/openresty/nginx/conf/nginx.conf"],
                   File["/usr/local/openresty/nginx/conf/lua/get_black_list.lua"],
		   File["/usr/local/openresty/nginx/conf/lua/token_verify.lua"],
                 ],
    onlyif      => '/usr/local/openresty/nginx/sbin/openresty -c /usr/local/openresty/nginx/conf/nginx.conf -t',
    refreshonly => true,
  }
}
