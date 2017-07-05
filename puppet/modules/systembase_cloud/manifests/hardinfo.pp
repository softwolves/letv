class systembase_cloud::hardinfo{
  file{"/letv/soft/tools/summary":
    ensure => file,
    mode   => 744,
    content => template("systembase_cloud/hardinfo.sh"),
  }
}
