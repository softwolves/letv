class systembase_newcdn_dev::install{
  package{"aria2":
    ensure   => present,
    provider => rpm,
    source   => "http://${rpmsource}/puppet/package/aria2-1.15.1-1.el6.x86_64.rpm",
  }

  package{"nali":
    ensure   => present,
    provider => rpm,
    source   => "http://${rpmsource}/puppet/package/nali-0.2-1.el6.x86_64.rpm",
  }

  package{"atop":
    ensure   => present,
    provider => rpm,
    source   => "http://${rpmsource}/puppet/package/atop-1.26-3.el6.x86_64.rpm",
  }

  package{"tcptraceroute":
    ensure   => present,
    provider => rpm,
    source   => "http://${rpmsource}/puppet/package/tcptraceroute-1.5-0.beta7.el6.rf.x86_64.rpm",
  }

  package{"nethogs":
    ensure   => present,
    provider => rpm,
    source   => "http://${rpmsource}/puppet/package/nethogs-0.8.0-1.el6.x86_64.rpm",
  }

  package{"letv-release":
    ensure   => present,
    provider => rpm,
    source   => "http://${rpmsource}/puppet/package/letv-release-1-0.noarch.rpm",
  }

  package{"librtmp":
    ensure   => present,
    provider => rpm,
    source   => "http://${rpmsource}/puppet/package/librtmp-2.3-1.el6.rf.x86_64.rpm",
  }

  package{"rtmpdump":
    ensure   => present,
    provider => rpm,
    source   => "http://${rpmsource}/puppet/package/rtmpdump-2.3-1.el6.rf.x86_64.rpm",
  }

  package{"libev":
    ensure   => present,
    provider => rpm,
    source   => "http://${rpmsource}/puppet/package/libev-4.03-3.el6.x86_64.rpm",
  }

  package{"python-setuptools":
    ensure   => present,
    provider => rpm,
    source   => "http://${rpmsource}/puppet/package/python-setuptools-0.6.10-3.el6.noarch.rpm",
  }

  package{"lighttpd-mod_geoip":
    ensure   => installed,
  }

  exec {"/usr/bin/pip":
    path      => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",
    command => "/usr/bin/easy_install  http://${rpmsource}/puppet/package/pip/pip-6.0.6.tar.gz;pip install http://${rpmsource}/puppet/package/pyip-0.7.tar.gz;pip install http://${rpmsource}/puppet/package/greenlet-0.4.5.zip;pip install http://${rpmsource}/puppet/package/gevent-1.0.1.tar.gz",
    #command => "/usr/bin/easy_install -i http://mirrors.aliyun.com/pypi/simple pip",
    require => Package['python-setuptools'],
    creates => "/usr/bin/pip"
  }

  exec {"stress_testing":
    path      => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",
    command => "pip install http://${rpmsource}/puppet/package/Werkzeug-0.10.4.tar.gz;pip install http://${rpmsource}/puppet/package/itsdangerous-0.24.tar.gz;pip install http://${rpmsource}/puppet/package/Jinja2-2.7.3.tar.gz;pip install http://${rpmsource}/puppet/package/Flask-0.10.1.tar.gz;pip install http://${rpmsource}/puppet/package/requests-2.6.0.tar.gz;pip install http://${rpmsource}/puppet/package/virtualenv-12.1.1-py2.py3-none-any.whl",
    #command => "/usr/bin/easy_install -i http://mirrors.aliyun.com/pypi/simple pip",
    require => Package['python-setuptools'],
    creates => "/usr/lib/python2.6/site-packages/Flask-0.10.1-py2.6.egg-info/PKG-INFO"
  }


#  exec {"install pyip gevent":
#    path      => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",
#    command => "pip install http://${rpmsource}/puppet/package/pyip-0.7.tar.gz;pip install http://${rpmsource}/puppet/package/greenlet-0.4.5.zip;pip install http://${rpmsource}/puppet/package/gevent-1.0.1.tar.gz",
#    require => Exec['/usr/bin/pip'],
#    creates => "/usr/lib/python2.6/site-packages/ip.py"
#  }

#  package{"pyip":
#    ensure   => present,
#    name     => pyip,
#    provider => pip,
#    require => Exec['/usr/bin/pip'],
#  }

#  package{"gevent":
#    ensure   => present,
#    name     => gevent,
#    provider => pip,
#    require => Exec['/usr/bin/pip'],
#  }

#  package{"greenlet":
#    ensure   => present,
#    name     => greenlet,
#    provider => pip,
#  }

#  package{"monit":
#    ensure   => absent,
#  }

  exec {"/usr/bin/monit":
#    command => "/bin/rpm -ivh --replacepkgs http://${rpmsource}/puppet/package/monit-5.5.1-2.x86_64.rpm",
    command => "/bin/rpm -e monit;/bin/rpm -ivh --replacepkgs http://${rpmsource}/puppet/package/monit-5.5.1-2.x86_64.rpm",
    creates => "/usr/bin/monit"
  }

  exec {"/usr/sbin/hpssacli":
#    command => "/bin/rpm -ivh --replacepkgs http://${rpmsource}/puppet/package/hpssacli-2.20-11.0.x86_64.rpm",
    command => "/bin/rpm -ivh --replacepkgs http://test.coop.gslb.letv.com/update/hpssacli-2.20-11.0.x86_64.rpm_fd1e29f4802e6cc28f9ee486743b849d",
    creates => "/usr/sbin/hpssacli"
  }

#  package{"":
#    ensure   => present,
#    provider => rpm,
#    source   => "http://${rpmsource}/puppet/package/",
#  }

} 
