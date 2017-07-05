class systembase_cloud_dev::profile{
  file{"/etc/profile":
    ensure => file,
    mode => 644,
    content => template("systembase_cloud_dev/profile"),
  }

  file{"/etc/bashrc":
    ensure => file,
    mode => 644,
    content => template("systembase_cloud_dev/bashrc"),
  }

}
