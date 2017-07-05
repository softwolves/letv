class systembase_newcdn_dev::service_start{
  service{ "crond":
    ensure     => running,
    enable     => true,
  }
}
