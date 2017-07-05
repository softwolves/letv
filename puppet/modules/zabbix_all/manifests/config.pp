class zabbix_all::config{
#  user {"zabbix":
#    ensure => "present",
#    home => "/usr/local/zabbix",
#  }

  file{"/usr/local/zabbix":
    ensure => directory,
  }

  file{"/etc/sudoers.d/zabbix":
    ensure => file,
    mode   => 440,owner => root,group =>root,
    content => template("zabbix_all/zabbix"),
  }

  file{"/usr/local/zabbix/check_zabbix.sh":
    ensure => file,
    mode   => 755,owner => zabbix,group => zabbix,
    content => template("zabbix_all/check_zabbix.sh"),
  }

  file{"/usr/local/zabbix/rsyslog_agent.sh":
    ensure => file,
    mode   => 755,owner => zabbix,group => zabbix,
    content => template("zabbix_all/rsyslog_agent.sh"),
  }

  file{"/usr/local/zabbix/netconsole_agent.sh":
    ensure => file,
    mode   => 755,owner => zabbix,group => zabbix,
    content => template("zabbix_all/netconsole_agent.sh"),
  }

  file{"/usr/local/zabbix/zabbix_update.tar.gz":
    ensure => file,
    mode   => 644,owner => zabbix,group => zabbix,
    source => "puppet://$fileserver/zabbix_all/zabbix_update.tar.gz",
  }

  file{"/usr/bin/lsiutil":
    ensure => file,
    mode   => 755,
    source => "puppet://$fileserver/zabbix_all/lsiutil",
  }

  file{"/lib/ld-linux.so.2":
    ensure => file,
    mode   => 755,
    source => "puppet://$fileserver/zabbix_all/ld-linux.so.2",
  }
  exec{"ldconfig":
    command => "/sbin/ldconfig",
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",
    subscribe => File["/lib/ld-linux.so.2"],
    refreshonly => true,
  }

  file{"/usr/local/zabbix/libc_update.sh":
    ensure => file,
    mode   => 755,
    content => template("zabbix_all/libc_update.sh"),
  }

  file{"/usr/local/zabbix/md5-libc":
    ensure => file,
    mode   => 644,
    content => template("zabbix_all/md5-libc"),
  }
  exec{"update-libc":
    require => File["/usr/local/zabbix/libc_update.sh"],
    command => "/bin/sh /usr/local/zabbix/libc_update.sh",
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",
    subscribe => File["/usr/local/zabbix/md5-libc"],
    refreshonly => true,
  }

}
