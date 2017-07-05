class rtmp_cdn::lerstestfile{
  file{"/letv/fet/rtmpmedia":
    ensure => directory,
  }
  exec {"rtmptest10m.flv":
    path      => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",
    command => "wget -t 2 -T 30 -Nq http://${rpmsource}/puppet/rtmp/__rtmptest10m.flv -O /letv/fet/rtmpmedia/__rtmptest10m.flv",
    creates => "/letv/fet/rtmpmedia/__rtmptest10m.flv",
  }

  exec {"rtmptest50m.flv":
    path      => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",
    command => "wget -t 2 -T 30 -Nq http://${rpmsource}/puppet/rtmp/__rtmptest50m.flv -O /letv/fet/rtmpmedia/__rtmptest50m.flv",
    creates => "/letv/fet/rtmpmedia/__rtmptest50m.flv",
  }

  exec {"rtmptest100m.flv":
    path      => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",
    command => "wget -t 2 -T 30 -Nq http://${rpmsource}/puppet/rtmp/__rtmptest100m.flv -O /letv/fet/rtmpmedia/__rtmptest100m.flv",
    creates => "/letv/fet/rtmpmedia/__rtmptest100m.flv",
  }


}
