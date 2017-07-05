class systembase_cdn_spe::hardinfo{
  file{"/letv/soft/tools/summary":
    ensure => file,
    mode   => 744,
    content => template("systembase_cdn_spe/hardinfo.sh"),
  }
}
