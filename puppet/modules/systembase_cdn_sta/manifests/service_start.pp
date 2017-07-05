class systembase_cdn_sta::service_start{
  service{ "crond":
    ensure     => running,
    enable     => true,
  }
}
