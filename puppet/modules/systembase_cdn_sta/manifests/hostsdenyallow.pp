class systembase_cdn_sta::hostsdenyallow{
  file{"/etc/hosts.allow":
    ensure => file,
    mode   => 644,
    content => template("systembase_cdn_sta/hosts.allow"),
  }

  file{"/etc/hosts.deny":
    ensure => file,
    mode   => 644,
    content => template("systembase_cdn_sta/hosts.deny"),
  }
}
