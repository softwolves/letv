class cto_all::install {

  file { "/letv/soft/nginx/cto_install.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("cto_all/cto_install.sh"),
  }

  exec { "install cto":
    require => File["/letv/soft/nginx/cto_install.sh"],
    command => "/bin/bash /letv/soft/nginx/cto_install.sh",
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",
    subscribe => File["/letv/soft/nginx/cto_install.sh"],
    refreshonly => true,
  }

}
