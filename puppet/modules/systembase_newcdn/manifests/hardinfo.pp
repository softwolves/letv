class systembase_newcdn::hardinfo{
  file{"/letv/soft/tools/summary":
    ensure => file,
    mode   => 744,
    content => template("systembase_newcdn/hardinfo.sh"),
  }
}
