class systembase_cdn::sudoers{
  file{"/etc/sudoers":
    ensure => file,
    mode => 440,owner => root,group => root,
    content => template("systembase_cdn/sudoers"),
   }
}
