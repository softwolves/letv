class ats_cloud_dev::install {

#  file { "/home/update/shell/ats_update.sh":
#    ensure => file,
#    mode => 755,owner => root,group => root,
#    content => template("ats_cloud_dev/ats_update.sh"),
#
#  }
#  file { "/home/update/puppetmd5file/md5-ats":
#    ensure => file,
#    mode => 644,
#    content => template("ats_cloud_dev/md5-ats"),
#  }
  package { "tcl":
    ensure => "8.5.7-6.el6",
    before => Package["trafficserver"],
  }
  package { "hwloc":
    ensure => "1.5-3.el6_5",
    before => Package["trafficserver"],
  }
  package { "trafficserver":
    ensure => '5.3.2-13.el6.old',
    provider => rpm,
    source => "http://test.coop.gslb.letv.com/update/trafficserver-5.3.2-13.el6.old.x86_64.rpm_d5609cff6b6d6471e4ac2c308c9a2850",
    before => Class["ats_cloud_dev::config"],
    require => Class["systembase_cloud_dev"],
    notify => Service["trafficserver"],
  }

  service { "trafficserver":
    ensure => running,
    hasrestart => true,
    hasstatus => true,
#    require => Package["trafficserver"],
#    subscribe => Package["trafficserver-plugins"],
  }

  exec { "restart-ats":
    #require => File["/home/update/shell/ats_update.sh"],
    command => "/usr/local/sbin/ats/bin/trafficserver stop;/usr/local/sbin/ats/bin/trafficserver stop; /etc/init.d/trafficserver restart",
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",
    subscribe => [  Package["trafficserver"],
                 ],
    refreshonly => true,

  }
}
