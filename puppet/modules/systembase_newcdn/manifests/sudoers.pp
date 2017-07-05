class systembase_newcdn::sudoers{
  file{"/etc/sudoers":
    ensure => file,
    mode => 440,owner => root,group => root,
    content => template("systembase_newcdn/sudoers"),
   }
}
