class systembase_store_dev::smokeping{
#  package {"echoping":
#    ensure => installed;
#}

  package{"postgresql-libs":
    ensure   => present,
    provider => rpm,
    source   => "http://115.182.94.72/puppet/package/postgresql-libs-8.4.13-1.el6_3.x86_64.rpm",
  }

  package{"echoping-libs":
    ensure   => present,
    require => Package["postgresql-libs"],
    provider => rpm,
    source   => "http://115.182.94.72/puppet/package/echoping-libs-6.0.2-4.x86_64.rpm",
  }

  package{"echoping":
    ensure   => present,
    require => Package["echoping-libs","postgresql-libs"],
    provider => rpm,
    source   => "http://115.182.94.72/puppet/package/echoping-6.0.2-4.x86_64.rpm",
  }

  file{"/data/smokeping/bin/smokeping.sh":
    ensure => file,
    mode => 755,owner => root,group => root,
    content => template("systembase_store_dev/smokeping.sh"),
  }

  file{"/data":
    ensure => directory,
  }

  exec {"smokpingpackages":
    path      => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",
    command => "wget -O /data/smokeping.tar http://${rpmsource}/puppet/package/smokeping.tar ; tar xvf /data/smokeping.tar -C /data/",
    creates => "/data/smokeping/bin/smokeping.dist"
  }

}
