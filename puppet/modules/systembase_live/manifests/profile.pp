class systembase_live::profile{
  file{"/etc/profile":
    ensure => file,
    mode => 644,
    content => template("systembase_live/profile"),
  }

  file{"/etc/bashrc":
    ensure => file,
    mode => 644,
    content => template("systembase_live/bashrc"),
  }

}
