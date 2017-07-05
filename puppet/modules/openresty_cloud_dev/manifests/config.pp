##
class openresty_cloud_dev::config {
  file{"/usr/local/openresty/nginx/conf/nginx.conf":
    ensure => file,
    mode   => 644,
    content => template("openresty_cloud_dev/nginx.conf"),
  }

  exec {"restart openresty":
    path      => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",
    command    => "killall -9 openresty ; /usr/local/openresty/nginx/sbin/openresty -c /usr/local/openresty/nginx/conf/nginx.conf",
    subscribe => File["/usr/local/openresty/nginx/conf/nginx.conf"],
    onlyif      => '/usr/local/openresty/nginx/sbin/openresty -c /usr/local/openresty/nginx/conf/nginx.conf -t',
    refreshonly => true,
  }
}
