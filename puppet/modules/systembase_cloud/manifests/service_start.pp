class systembase_cloud::service_start{
  service{ "crond":
    ensure     => running,
    enable     => true,
  }
}
