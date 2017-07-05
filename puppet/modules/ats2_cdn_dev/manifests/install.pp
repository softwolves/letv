class ats2_cdn_dev::install {

  file { "/home/update/shell/ats_update.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("ats2_cdn_dev/ats_update.sh"),

  }
  file { "/home/update/puppetmd5file/md5-ats":
    ensure => file,
    mode => 644,
    content => template("ats2_cdn_dev/md5-ats"),
  }

  package { "trafficserver":
    ensure => '4.2.3-59.el6',
    provider => rpm,
    source => "http://test.coop.gslb.letv.com/update/trafficserver-4.2.3-59.el6.x86_64.rpm_32715d1f83ffe71ae18ec71b5c32ad92",
    before => Class["ats2_cdn_dev::config"],
    notify => Service["trafficserver"],
  }

#  package { "trafficserver-plugins":
#    #ensure => "4.2.3-57.el6",
#    ensure => "4.2.3-58.el6",
#    before => Class["ats2_cdn_dev::config"],
#    notify => Service["trafficserver"],
#  }

  package { "trafficserver-plugins":
    #ensure => "4.2.3-57.el6",
    ensure => absent,
    before => Package["trafficserver"],
#    before => Class["ats5_cdn_dev::config"],
#    notify => Service["trafficserver"],
  }


  service { "trafficserver":
    ensure => running,
    hasrestart => true,
    hasstatus => true,
    require => Package["trafficserver"],
  }

  exec { "update-ats":
    require => File["/home/update/shell/ats_update.sh"],
    command => "/sbin/ldconfig ; sh /home/update/shell/ats_update.sh",
    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",
    subscribe => [  File["/home/update/puppetmd5file/md5-ats"],
                 ],
    refreshonly => true,

  }
}
