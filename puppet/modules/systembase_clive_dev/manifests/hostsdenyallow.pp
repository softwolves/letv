class systembase_clive_dev::hostsdenyallow{
  file{"/etc/hosts.allow":
    ensure => file,
    mode   => 644,
    content => template("systembase_clive_dev/hosts.allow"),
  }

  file{"/etc/hosts.deny":
    ensure => file,
    mode   => 644,
    content => template("systembase_clive_dev/hosts.deny"),
  }
}
