class systembase_store_dev::hardinfo{
  file{"/letv/soft/tools/summary":
    ensure => file,
    mode   => 744,
    content => template("systembase_store_dev/hardinfo.sh"),
  }
}
