class systembase_cdn_qa::service_start{
  service{ "crond":
    ensure     => running,
    enable     => true,
  }
}
