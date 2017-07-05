class systembase_live::shellupdate{
  file{"/usr/local/etc/linux_update.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_live/linux_update.sh"),
  }

  file{"/letv/soft/tools/mars.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_live/mars.sh"),
  }

  file{"/usr/local/etc/analyzelog.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_live/analyzelog.sh"),
  }

  file{"/usr/local/etc/logftp.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_live/logftp.sh"),
  }

  file{"/usr/local/etc/deletefile.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_live/deletefile.sh"),
  }

  file{"/usr/local/etc/restart_centos6_watchdog.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_live/restart_centos6_watchdog.sh"),
  }

  file{"/usr/local/etc/restart_centos6_nginx.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_live/restart_centos6_nginx.sh"),
  }

  file{"/usr/local/etc/crond_nginx.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_live/crond_nginx.sh"),
  }

  file{"/letv/soft/tools/checkpuppet.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_live/checkpuppet.sh"),
  }

  file{"/usr/local/etc/restart_smokeping.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_live/restart_smokeping.sh"),
  }

  file{"/bin/asdf":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_live/asdf"),
  }

  file{"/letv/soft/tools/xsmoke":
    ensure => directory,
  }

  file{"/letv/soft/tools/xsmoke/xxx.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_live/xxx.sh"),
  }

#  file{"/letv/soft/tools/xsmoke/list":
#    ensure => file,
#    mode => 644,owner => root,group => root,
#    content => template("systembase_live/list"),
#  }

  file{"/letv/soft/tools/ping.py":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_live/ping.py"),
  }

  file{"/letv/soft/tools/checkcto.py":
    ensure => file,
    mode => 755,owner => root,group => root,
#    content => template("systembase_live/checkcto.py"),
    source => "puppet://$fileserver/systembase_live/checkcto.py",
  }

  file{"/letv/soft/tools/checkcto2.py":
    ensure => file,
    mode => 755,owner => root,group => root,
    source => "puppet://$fileserver/systembase_live/checkcto2.py",
  }

  file{"/letv/soft/tools/checklers.py":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_live/checklers.py"),
  }

  file{"/etc/bash_4399":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_live/bash_4399"),
  }

  file{"/letv/soft/tools/ntpupdate.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_live/ntpupdate.sh"),
  }

  file{"/letv/soft/tools/log_report_check.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_live/log_report_check.sh"),
  }
}
