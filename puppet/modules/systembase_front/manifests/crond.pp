class systembase_front::crond{
  file{"/var/spool/cron/root":
    ensure => file,
    mode => 600,owner => root,group => root,
    content => template("systembase_front/root"),
  }
  exec { "restart-crond":
  command => "service crond reload",
  path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",
  subscribe => File["/var/spool/cron/root"],
  refreshonly => true,
  }
}
