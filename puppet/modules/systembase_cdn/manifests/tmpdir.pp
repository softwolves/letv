class systembase_cdn::tmpdir{
  file{"/var/tmp/nginx":
    ensure => directory,
  }

  file{"/var/tmp/nginx/client_body_temp":
    ensure => directory,
  }

  file { "/letv/soft":
    ensure => directory,
  }

  file { "/letv/soft/nginx":
    ensure => directory,
  }

  file { "/home/lihongfu":
    ensure => directory,
    owner => "www",
  }

  file { "/letv/soft/tools":
    ensure => directory,
    owner => "root",
  }

  file { "/usr/local/zabbix/.ssh":
    ensure => directory,
    owner => "zabbix",
    group => "zabbix",
    mode  => "700"
  }

}
