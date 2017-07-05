class systembase_front_dev::service_start{
  service{ "crond":
    ensure     => running,
    enable     => true,
  }
}
