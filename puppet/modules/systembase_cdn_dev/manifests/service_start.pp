class systembase_cdn_dev::service_start{
  service{ "crond":
    ensure     => running,
    enable     => true,
  }
}
