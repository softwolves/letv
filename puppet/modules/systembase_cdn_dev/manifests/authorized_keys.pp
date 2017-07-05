class systembase_cdn_dev::authorized_keys{
  file {"/root/.ssh/authorized_keys":
    owner   => root,
    group   => root,
    mode    => 600,
    ensure  => present,
    content => template("systembase_cdn_dev/authorized_keys.erb"),
  }

  file {"/usr/local/zabbix/.ssh/authorized_keys":
    owner   => zabbix,
    group   => zabbix,
    mode    => 600,
    ensure  => present,
    content => template("systembase_cdn_dev/zabbix_authorized_keys.erb"),
  }

}
