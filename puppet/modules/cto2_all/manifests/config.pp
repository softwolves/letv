class cto2_all::config {

  file {"/cto2":
    ensure => directory,
  }

  file {"/cto2/lib":
    ensure => directory,
  }

  file { "/cto2/ctocmd":
    ensure => file,
    mode => 755,owner => root,group => root,
    source => "puppet://$fileserver/cto2_all/ctocmd",
  }

#  file { "/cto2/ctod":
#    ensure => file,
#    mode => 755,owner => root,group => root,
#    source => "puppet://$fileserver/cto2_all/ctod",
#  }

  file { "/cto2/ctoguard":
    ensure => file,
    mode => 755,owner => root,group => root,
    source => "puppet://$fileserver/cto2_all/ctoguard",    
  }

  file { "/cto2/ctostart":
    ensure => file,
    mode => 755,owner => root,group => root,
    source => "puppet://$fileserver/cto2_all/ctostart",    
  }

  file { "/cto2/default.conf":
    ensure => file,
    mode => 644,owner => root,group => root,
    content => template("cto2_all/default.conf"),
  }

  file { "/cto2/ctoclear":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("cto2_all/ctoclear"),
  }

  file { "/cto2/log.conf":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("cto2_all/log.conf"),
  }

  file { "/etc/init.d/cto2.3":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("cto2_all/cto2.3"),
  }

  file { "/cto2/lib/libboost_program_options.so.1.58.0":
    ensure => file,
    mode => 755,owner => root,group => root,
    source => "puppet://$fileserver/cto2_all/libboost_program_options.so.1.57.0",    
  }

#  file { "/cto2/lib/libstdc++.so.6":
#    ensure => file,
#    mode => 755,owner => root,group => root,
#    source => "puppet://$fileserver/cto2_all/libstdc++.so.6",    
#  }

  exec {"restart cto2":
    path      => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin:/cto/bin",
    require => [ File["/cto2/ctostart"], File["/etc/init.d/cto2.3"] ],
    command => "/etc/init.d/cto2.3 restart",
##    command => "/sbin/iptables -t nat -D OUTPUT -p tcp --dport 50001:65000 -j REDIRECT --to-ports 8256;/sbin/iptables -t nat -D PREROUTING -p tcp --dport 50001:65000 -j REDIRECT --to-ports 8256;killall -9 ctoguard;killall -9 ctod;/sbin/iptables -t nat -D OUTPUT -p tcp --dport 50001:65000 -j REDIRECT --to-ports 8256;/sbin/iptables -t nat -D PREROUTING -p tcp --dport 50001:65000 -j REDIRECT --to-ports 8256",
    subscribe => [ File["/cto2/ctocmd"],
#                   File["/cto2/ctod"],
                   File["/cto2/ctoguard"],
                   File["/cto2/ctoclear"],
                   File["/cto2/log.conf"],
                   File["/cto2/ctostart"],
                   File["/cto2/default.conf"],
                   File["/cto2/lib/libboost_program_options.so.1.58.0"],
#                   File["/cto2/lib/libstdc++.so.6"],
                 ],
    refreshonly => true,

  }
}
