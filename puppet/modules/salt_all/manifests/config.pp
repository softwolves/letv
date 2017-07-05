class salt_all::config{
  file {"/etc/salt/":
    ensure => directory,
  }

  file {"/etc/salt/minion":
    ensure => file,
    mode   => 644,
    content => template("salt_all/minion"),

  }
}
