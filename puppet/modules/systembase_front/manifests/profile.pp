class systembase_front::profile{
  file{"/etc/profile":
    ensure => file,
    mode => 644,
    content => template("systembase_front/profile"),
  }

  file{"/etc/bashrc":
    ensure => file,
    mode => 644,
    content => template("systembase_front/bashrc"),
  }

}
