class ats5_cdn::install {

#  file { "/home/update/shell/ats_update.sh":
#    ensure => file,
#    mode => 755,owner => root,group => root,
#    content => template("ats5_cdn/ats_update.sh"),
#
#  }
#  file { "/home/update/puppetmd5file/md5-ats":
#    ensure => file,
#    mode => 644,
#    content => template("ats5_cdn/md5-ats"),
#  }

  package { "trafficserver":
    ensure => '5.3.2-13.el6',
    provider => rpm,
    source => "http://test.coop.gslb.letv.com/update/trafficserver-5.3.2-13.el6.x86_64.rpm_4dfe3e20640930ced1fd7bf00d5c7695",
    before => Class["ats5_cdn::config"],
    notify => Service["trafficserver"],
  }

  package { "trafficserver-plugins":
    #ensure => "4.2.3-57.el6",
    ensure => absent,
    before => Package["trafficserver"],
#    before => Class["ats5_cdn::config"],
#    notify => Service["trafficserver"],
  }

  service { "trafficserver":
    ensure => running,
    hasrestart => true,
    hasstatus => true,
    require => Package["trafficserver"],
#    subscribe => Package["trafficserver-plugins"],
  }

#  exec { "update-ats":
#    require => File["/home/update/shell/ats_update.sh"],
#    command => "/sbin/ldconfig ; sh /home/update/shell/ats_update.sh",
#    path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",
#    subscribe => [  File["/home/update/puppetmd5file/md5-ats"],
#                 ],
#    refreshonly => true,
#
#  }
}
