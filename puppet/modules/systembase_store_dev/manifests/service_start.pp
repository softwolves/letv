class systembase_store_dev::service_start{
  service{ "crond":
    ensure     => running,
    enable     => true,
  }
}
