class systembase_store_dev::yumrepo{
  file{"/etc/yum.repos.d/letv-pkgs.repo":
    ensure => file,
    mode => 644,
    content => template("systembase_store_dev/letv-pkgs.repo"),
  }

  file{"/etc/yum.repos.d/CentOS-Base.repo":
    ensure => file,
    mode => 644,owner => root,group => root,
    content => template("systembase_store_dev/CentOS-Base.repo"),
  }

  file{"/etc/yum.repos.d/CentOS-Debuginfo.repo":
    ensure => file,
    mode => 644,owner => root,group => root,
    content => template("systembase_store_dev/CentOS-Debuginfo.repo"),
  }

  file{"/etc/yum.repos.d/CentOS-Media.repo":
    ensure => file,
    mode => 644,owner => root,group => root,
    content => template("systembase_store_dev/CentOS-Media.repo"),
  }

  file{"/etc/yum.repos.d/CentOS-Vault.repo":
    ensure => file,
    mode => 644,owner => root,group => root,
    content => template("systembase_store_dev/CentOS-Vault.repo"),
  }

  file{"/etc/yum.repos.d/my.repo":
    ensure => absent,
  }

  exec{"yum clean all":
    path      => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",
    subscribe => [  File["/etc/yum.repos.d/letv-pkgs.repo"],
                    File["/etc/yum.repos.d/CentOS-Base.repo"],
                    File["/etc/yum.repos.d/CentOS-Debuginfo.repo"],
                    File["/etc/yum.repos.d/CentOS-Media.repo"],
                    File["/etc/yum.repos.d/CentOS-Vault.repo"],
                 ],
    refreshonly => true,
  }

  package { "bash":
#    ensure => "latest",
#    ensure => "4.1.2-15.el6_5.2",
#    ensure   => present,
    ensure  =>  "4.1.2-60.el6.2",
    provider => rpm,
    source   => "http://115.182.94.72/puppet/package/bash-4.1.2-60.el6.2.x86_64.rpm",
  }

  package { "ruby-shadow":
    ensure => present,
    provider => rpm,
    source   => "http://115.182.94.72/puppet/package/ruby-shadow-1.4.1-13.el6.x86_64.rpm",
  }

#  package { "watchdog2-front":
#    ensure  =>  "1.0.0-24.el6",
#    provider => rpm,
#    source   => "http://115.182.94.72/puppet/package/watchdog2/front/watchdog2-1.0.0-24.el6.x86_64.rpm",
#  }

#  package { "openssl":
#    ensure => "1.0.1e-42.el6",
#    provider => rpm,
#    source   => "http://115.182.94.72/puppet/package/openssl/openssl-1.0.1e-42.el6.x86_64.rpm",
#  }

}
