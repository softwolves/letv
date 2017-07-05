class systembase_clive::profile{
  file{"/etc/profile":
    ensure => file,
    mode => 644,
    content => template("systembase_clive/profile"),
  }

  file{"/etc/bashrc":
    ensure => file,
    mode => 644,
    content => template("systembase_clive/bashrc"),
  }

}
