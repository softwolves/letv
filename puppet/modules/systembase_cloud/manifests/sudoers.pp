class systembase_cloud::sudoers{
  file{"/etc/sudoers":
    ensure => file,
    mode => 440,owner => root,group => root,
    content => template("systembase_cloud/sudoers"),
   }
}
