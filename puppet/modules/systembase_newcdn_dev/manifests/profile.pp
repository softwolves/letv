class systembase_newcdn_dev::profile{
  file{"/etc/profile":
    ensure => file,
    mode => 644,
    content => template("systembase_newcdn_dev/profile"),
  }

  file{"/etc/bashrc":
    ensure => file,
    mode => 644,
    content => template("systembase_newcdn_dev/bashrc"),
  }

}
