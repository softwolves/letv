class systembase_cdn::hardinfo{
  file{"/letv/soft/tools/summary":
    ensure => file,
    mode   => 744,
    content => template("systembase_cdn/hardinfo.sh"),
  }
}
