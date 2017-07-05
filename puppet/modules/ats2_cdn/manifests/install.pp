class ats2_cdn::install {

  file { "/home/update/shell/ats_update.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("ats2_cdn/ats_update.sh"),

  }
  file { "/home/update/puppetmd5file/md5-ats":
    ensure => file,
    mode => 644,
    content => template("ats2_cdn/md5-ats"),
  }

  package { "trafficserver":
    ensure => '4.2.3-52.el6',
    provider => rpm,
    source => "http://test.coop.gslb.letv.com/update/trafficserver-4.2.3-52.el6.x86_64.rpm_19cd89b61ed14c405de7f4141f871a4e",
    before => Class["ats2_cdn::config"],
  }

  package { "trafficserver-plugins":
    #ensure => "4.2.3-57.el6",
    ensure => "4.2.3-58.el6",
    before => Class["ats2_cdn::config"],
    notify => Service["trafficserver"],
  }

  service { "trafficserver":
    ensure => running,
    hasrestart => true,
    hasstatus => true,
    require => Package["trafficserver","trafficserver-plugins"],
    subscribe => Package["trafficserver-plugins"],
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
