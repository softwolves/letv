class systembase_cdn::profile{
  file{"/etc/profile":
    ensure => file,
    mode => 644,
    content => template("systembase_cdn/profile"),
  }

  file{"/etc/bashrc":
    ensure => file,
    mode => 644,
    content => template("systembase_cdn/bashrc"),
  }

}
