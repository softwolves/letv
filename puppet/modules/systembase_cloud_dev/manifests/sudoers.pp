class systembase_cloud_dev::sudoers{
  file{"/etc/sudoers":
    ensure => file,
    mode => 440,owner => root,group => root,
    content => template("systembase_cloud_dev/sudoers"),
   }
}
