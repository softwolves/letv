class systembase_cloud_dev::service_start{
  service{ "crond":
    ensure     => running,
    enable     => true,
  }
}
