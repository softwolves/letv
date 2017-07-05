class openresty_cloud::install {
  file { "/letv/soft/nginx/openresty_update.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("openresty_cloud/openresty_update.sh"),
  }

  file { "/letv/soft/nginx/md5-openresty":
    ensure => file,
    mode => 644,
    content => template("openresty_cloud/md5-openresty"),
  }

  exec { "update-openresty":
    require => File["/letv/soft/nginx/openresty_update.sh"],
    command => "sh /letv/soft/nginx/openresty_update.sh",
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",
    subscribe =>  File["/letv/soft/nginx/md5-openresty"],
    refreshonly => true,
#    creates => "usr/local/openresty/luajit/lib/libluajit-5.1.so.2.1.0",
  }

}
