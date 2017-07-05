class systembase_store::profile{
  file{"/etc/profile":
    ensure => file,
    mode => 644,
    content => template("systembase_store/profile"),
  }

  file{"/etc/bashrc":
    ensure => file,
    mode => 644,
    content => template("systembase_store/bashrc"),
  }

}
