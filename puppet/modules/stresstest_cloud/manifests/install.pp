class stresstest_cloud::install {
  file {"/letv/soft/tools/stresstest":
    ensure => directory,
  }
  file { "/letv/soft/nginx/stresstest_update.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("stresstest_cloud/stresstest_update.sh"),

  }
  file { "/letv/soft/nginx/md5-stresstest":
    ensure => file,
    mode => 644,
    content => template("stresstest_cloud/md5-stresstest"),
  }
  exec { "update-stresstest":
    require => File["/letv/soft/nginx/stresstest_update.sh"],
    command => "sh /letv/soft/nginx/stresstest_update.sh",
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",
    subscribe =>   [ File["/letv/soft/nginx/md5-stresstest"],
                     File["/letv/soft/nginx/stresstest_update.sh"],
                   ],
    refreshonly => true,

  }

}
