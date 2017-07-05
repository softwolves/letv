class systembase_newcdn::shellupdate{
  file{"/letv/fet/core":
    ensure => directory,
  }

  file{"/usr/local/etc/linux_update.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_newcdn/linux_update.sh"),
  }

  file{"/letv/soft/tools/mars.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_newcdn/mars.sh"),
  }

  file{"/letv/soft/tools/hermes.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_newcdn/hermes.sh"),
  }

  file{"/letv/soft/tools/dmptest.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_newcdn/dmptest.sh"),
  }

  file{"/letv/soft/tools/imgotest.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_newcdn/imgotest.sh"),
  }

  file{"/usr/local/etc/analyzelog.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_newcdn/analyzelog.sh"),
  }

  file{"/usr/local/etc/logftp.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_newcdn/logftp.sh"),
  }

  file{"/usr/local/etc/deletefile.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_newcdn/deletefile.sh"),
  }

  file{"/usr/local/etc/restart_centos6_watchdog.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_newcdn/restart_centos6_watchdog.sh"),
  }

  file{"/usr/local/etc/restart_centos6_nginx.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_newcdn/restart_centos6_nginx.sh"),
  }

  file{"/usr/local/etc/crond_nginx.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_newcdn/crond_nginx.sh"),
  }

  file{"/usr/local/etc/restart_centos6_crtmpserver.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_newcdn/restart_centos6_crtmpserver.sh"),
  }

  file{"/letv/soft/tools/checkpuppet.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_newcdn/checkpuppet.sh"),
  }

  file{"/letv/soft/tools/checkfile.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_newcdn/checkfile.sh"),
  }


  file{"/usr/local/etc/restart_smokeping.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_newcdn/restart_smokeping.sh"),
  }

  file{"/bin/asdf":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_newcdn/asdf"),
  }

  file{"/letv/soft/tools/cdnwebtsd.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_newcdn/cdnwebtsd.sh"),
  }

  file{"/usr/local/etc/check_ats.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_newcdn/check_ats.sh"),
  }

  file{"/etc/init.d/crtmpserver":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_newcdn/crtmpserver"),
  }

  file{"/letv/soft/tools/xsmoke":
    ensure => directory,
  }

  file{"/letv/soft/tools/xsmoke/xxx.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_newcdn/xxx.sh"),
  }

#  file{"/letv/soft/tools/xsmoke/list":
#   ensure => file,
#    mode => 644,owner => root,group => root,
#    content => template("systembase_newcdn/list"),
#  }

  file{"/letv/soft/tools/disk_error_check.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_newcdn/disk_error_check.sh"),
  }

  file{"/letv/soft/tools/ping.py":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_newcdn/ping.py"),
  }

  file{"/letv/soft/tools/cdnlog.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_newcdn/cdnlog.sh"),
  }

  file{"/letv/soft/tools/checkcto2.py":
    ensure => file,
    mode => 755,owner => root,group => root,
    source => "puppet://$fileserver/systembase_newcdn/checkcto2.py",
  }

  file{"/letv/soft/tools/checkcrs.py":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_newcdn/checkcrs.py"),
  }

  file{"/letv/soft/tools/syscheck.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_newcdn/syscheck.sh"),
  }

  file{"/etc/bash_4399":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_newcdn/bash_4399"),
  }

  file{"/letv/fet/l.html":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_newcdn/l.html"),
  }

  file{"/letv/fet/noc.gif":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_newcdn/noc.gif"),
  }

  file{"/letv/fet/ov-connect.html":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_newcdn/ov-connect.html"),
  }

  file{"/letv/fet/ov-proxy.html":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_newcdn/ov-proxy.html"),
  }

  file{"/letv/fet/pano-proxy.html":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_newcdn/pano-proxy.html"),
  }

  file{"/letv/fet/robots.txt":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_newcdn/robots.txt"),
  }

  file{"/letv/soft/tools/ntpupdate.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_newcdn/ntpupdate.sh"),
  }

  file{"/letv/soft/tools/log_report_check.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_newcdn/log_report_check.sh"),
  }

  file{"/letv/soft/tools/get_source.py":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_newcdn/get_source.py"),
  }

  file{"/usr/local/zabbix/script/curl_proxy.py":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_newcdn/curl_proxy.py"),
  }

  file{"/etc/init.d/lers":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_newcdn/lers"),
  }
}
