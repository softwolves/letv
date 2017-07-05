class systembase_store::hardinfo{
  file{"/letv/soft/tools/summary":
    ensure => file,
    mode   => 744,
    content => template("systembase_store/hardinfo.sh"),
  }
}
