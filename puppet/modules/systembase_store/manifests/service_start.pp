class systembase_store::service_start{
  service{ "crond":
    ensure     => running,
    enable     => true,
  }
}
