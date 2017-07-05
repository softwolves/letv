class systembase_cloud_dev::hardinfo{
  file{"/letv/soft/tools/summary":
    ensure => file,
    mode   => 744,
    content => template("systembase_cloud_dev/hardinfo.sh"),
  }
}
