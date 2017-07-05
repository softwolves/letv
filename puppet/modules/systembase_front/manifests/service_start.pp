class systembase_front::service_start{
  service{ "crond":
    ensure     => running,
    enable     => true,
  }
}
