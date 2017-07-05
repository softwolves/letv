class systembase_store_dev::sudoers{
  file{"/etc/sudoers":
    ensure => file,
    mode => 440,owner => root,group => root,
    content => template("systembase_store_dev/sudoers"),
   }
}
