class systembase_cloud::profile{
  file{"/etc/profile":
    ensure => file,
    mode => 644,
    content => template("systembase_cloud/profile"),
  }

  file{"/etc/bashrc":
    ensure => file,
    mode => 644,
    content => template("systembase_cloud/bashrc"),
  }

}
