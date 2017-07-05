class collector_cdn_qa::config {
  file{["/opt/project","/opt/project/collector","/opt/project/collector/conf","/opt/project/collector/bin"]:
    ensure => directory,
    recurse => true,
  }

  file { "/opt/project/collector/bin/collector":
    ensure => file,
    mode => 755,owner => root,group => root,
    source => "puppet://$fileserver/collector_cdn_qa/collector",
  }

  file { "/opt/project/collector/conf/collector.conf":
    ensure => file,
    mode => 644,owner => root,group => root,
    content => template("collector_cdn_qa/collector.conf"),
  }

  exec{"restart collector":
    path      => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin:/cto/bin",
    command => "killall -9 collector;/opt/project/collector/bin/collector -d -c /opt/project/collector/conf/collector.conf",
    subscribe => [ File["/opt/project/collector/bin/collector"],
                   File["/opt/project/collector/conf/collector.conf"],
                 ],
    refreshonly => true,
  }
}
