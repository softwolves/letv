class systembase_cdn_dev::hardinfo{
  file{"/letv/soft/tools/summary":
    ensure => file,
    mode   => 744,
    content => template("systembase_cdn_dev/hardinfo.sh"),
  }
}
