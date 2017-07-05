class systembase_cdn_qa::rsyslog_config {

#  file { "/etc/rsyslog.conf":
#    ensure => file,
#    mode => 644,
#    content => template("systembase_cdn_qa/rsyslog.conf"),
#    notify  => Class['systembase_cdn_qa::rsyslog_service'],
#  }

#  file { "/etc/logrotate.d/syslog":
#    ensure => file,
#    mode => 644,
#    content => template("systembase_cdn_qa/syslog"),
#  }

  file { "/etc/rsyslog.d/crtmp.conf":
    ensure => file,
    mode => 644,
    content => template("systembase_cdn_qa/crtmp.conf"),
    require => Package["rsyslog"],
    notify => Service["rsyslog"]
  }
  package { "rsyslog":
    ensure => '8.13.0-1.el6',
    provider => rpm,
    source => "http://test.coop.gslb.letv.com/update/rsyslog-8.13.0-1.el6.x86_64.rpm_73a0ceb2de6f9638048e355843c40ee2",
    require => [ Package["libgt"],
                 Package["liblogging"],
                 Package["libksi"], 
                 Package["libestr"], 
                 Package["json-c"], 
                 File["/letv/soft/tools/rsyslog_update.sh"],
               ],
  }
  service { "rsyslog":
    ensure => running,
    hasrestart => true,
    hasstatus => true,
    require => Package["rsyslog"],
    subscribe => File["/etc/rsyslog.d/crtmp.conf"],
  }

  package { "libgt":
    ensure => '0.3.11-1.el6',
    provider => rpm,
    source => "http://test.coop.gslb.letv.com/update/libgt-0.3.11-1.el6.x86_64.rpm_6a166d47e8679b2043713823819e0581",
  }

  package { "liblogging":
    ensure => '1.0.5-1.el6',
    provider => rpm,
    source => "http://test.coop.gslb.letv.com/update/liblogging-1.0.5-1.el6.x86_64.rpm_111ed98fbbb69fab441c4d3ccc91557a",
  }

  package { "libksi":
    ensure => '3.2.2.0-1.el6',
    provider => rpm,
    source => "http://test.coop.gslb.letv.com/update/libksi-3.2.2.0-1.el6.x86_64.rpm_626ead026cb2ed466c24694b062c504f",
  }

  package { "libestr":
    ensure => '0.1.9-2.el6',
    provider => rpm,
    source => "http://test.coop.gslb.letv.com/update/libestr-0.1.9-2.el6.x86_64.rpm_d9d2728131bdac14e9424673f719aff7",
  }

  package { "json-c":
    ensure => '0.11-12.el6',
    provider => rpm,
    source => "http://test.coop.gslb.letv.com/update/json-c-0.11-12.el6.x86_64.rpm_1c1ab6199354537427b49166896f6a47",
  }

  file{"/letv/soft/tools/rsyslog_update.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_cdn_qa/rsyslog_update.sh"),
  }

  exec{"rsyslog_update":
    path      => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",
    command   => "/letv/soft/tools/rsyslog_update.sh",
    subscribe => [  File["/letv/soft/tools/rsyslog_update.sh"],
                 ],
    refreshonly => true,
  }

  file{"/var/log/secure":
    mode => 644,
  }

}
