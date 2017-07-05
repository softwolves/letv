class systembase_cloud::shellupdate{
  file{"/letv/fet/core":
    ensure => directory,
  }

  file{"/usr/local/etc/linux_update.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_cloud/linux_update.sh"),
  }

  file{"/letv/soft/tools/mars.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_cloud/mars.sh"),
  }

  file{"/letv/soft/tools/hermes.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_cloud/hermes.sh"),
  }

  file{"/letv/soft/tools/dmptest.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_cloud/dmptest.sh"),
  }

  file{"/letv/soft/tools/imgotest.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_cloud/imgotest.sh"),
  }

  file{"/usr/local/etc/analyzelog.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_cloud/analyzelog.sh"),
  }

  file{"/usr/local/etc/logftp.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_cloud/logftp.sh"),
  }

  file{"/usr/local/etc/deletefile.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_cloud/deletefile.sh"),
  }

  file{"/usr/local/etc/restart_centos6_watchdog.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_cloud/restart_centos6_watchdog.sh"),
  }

  file{"/usr/local/etc/restart_centos6_nginx.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_cloud/restart_centos6_nginx.sh"),
  }

  file{"/usr/local/etc/crond_nginx.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_cloud/crond_nginx.sh"),
  }

  file{"/usr/local/etc/crond_watchdog.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_cloud/crond_watchdog.sh"),
  }

  file{"/usr/local/etc/restart_centos6_crtmpserver.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_cloud/restart_centos6_crtmpserver.sh"),
  }

  file{"/letv/soft/tools/checkpuppet.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_cloud/checkpuppet.sh"),
  }

  file{"/letv/soft/tools/checkfile.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_cloud/checkfile.sh"),
  }


  file{"/usr/local/etc/restart_smokeping.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_cloud/restart_smokeping.sh"),
  }

  file{"/bin/asdf":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_cloud/asdf"),
  }

  file{"/letv/soft/tools/cdnwebtsd.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_cloud/cdnwebtsd.sh"),
  }

  file{"/usr/local/etc/check_ats.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_cloud/check_ats.sh"),
  }

  file{"/etc/init.d/crtmpserver":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_cloud/crtmpserver"),
  }

  file{"/letv/soft/tools/xsmoke":
    ensure => directory,
  }

  file{"/letv/soft/tools/xsmoke/xxx.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_cloud/xxx.sh"),
  }

#  file{"/letv/soft/tools/xsmoke/list":
#   ensure => file,
#    mode => 644,owner => root,group => root,
#    content => template("systembase_cloud/list"),
#  }

  file{"/letv/soft/tools/disk_error_check.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_cloud/disk_error_check.sh"),
  }

  file{"/letv/soft/tools/ping.py":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_cloud/ping.py"),
  }

  file{"/letv/soft/tools/cdnlog.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_cloud/cdnlog.sh"),
  }

  file{"/letv/soft/tools/checkcto2.py":
    ensure => file,
    mode => 755,owner => root,group => root,
    source => "puppet://$fileserver/systembase_cloud/checkcto2.py",
  }

  file{"/letv/soft/tools/checkcrs.py":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_cloud/checkcrs.py"),
  }

  file{"/letv/soft/tools/syscheck.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_cloud/syscheck.sh"),
  }

  file{"/etc/bash_4399":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_cloud/bash_4399"),
  }

  file{"/letv/fet/l.html":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_cloud/l.html"),
  }

  file{"/letv/fet/noc.gif":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_cloud/noc.gif"),
  }

  file{"/letv/fet/ov-connect.html":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_cloud/ov-connect.html"),
  }

  file{"/letv/fet/ov-proxy.html":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_cloud/ov-proxy.html"),
  }

  file{"/letv/fet/pano-proxy.html":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_cloud/pano-proxy.html"),
  }

  file{"/letv/fet/robots.txt":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_cloud/robots.txt"),
  }

  file{"/letv/soft/tools/ntpupdate.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_cloud/ntpupdate.sh"),
  }

  file{"/letv/soft/tools/log_report_check.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_cloud/log_report_check.sh"),
  }

  file{"/letv/soft/tools/get_source.py":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_cloud/get_source.py"),
  }

  file{"/usr/local/zabbix/script/curl_proxy.py":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_cloud/curl_proxy.py"),
  }
}
