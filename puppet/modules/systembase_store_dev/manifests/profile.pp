class systembase_store_dev::profile{
  file{"/etc/profile":
    ensure => file,
    mode => 644,
    content => template("systembase_store_dev/profile"),
  }

  file{"/etc/bashrc":
    ensure => file,
    mode => 644,
    content => template("systembase_store_dev/bashrc"),
  }

}
