class systembase_newcdn::profile{
  file{"/etc/profile":
    ensure => file,
    mode => 644,
    content => template("systembase_newcdn/profile"),
  }

  file{"/etc/bashrc":
    ensure => file,
    mode => 644,
    content => template("systembase_newcdn/bashrc"),
  }

}
