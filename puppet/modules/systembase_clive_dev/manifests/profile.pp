class systembase_clive_dev::profile{
  file{"/etc/profile":
    ensure => file,
    mode => 644,
    content => template("systembase_clive_dev/profile"),
  }

  file{"/etc/bashrc":
    ensure => file,
    mode => 644,
    content => template("systembase_clive_dev/bashrc"),
  }

}
