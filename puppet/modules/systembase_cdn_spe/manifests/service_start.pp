class systembase_cdn_spe::service_start{
  service{ "crond":
    ensure     => running,
    enable     => true,
  }
}
