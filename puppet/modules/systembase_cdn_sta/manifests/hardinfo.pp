class systembase_cdn_sta::hardinfo{
  file{"/letv/soft/tools/summary":
    ensure => file,
    mode   => 744,
    content => template("systembase_cdn_sta/hardinfo.sh"),
  }
}
