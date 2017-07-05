class systembase_live_dev::hardinfo{
  file{"/letv/soft/tools/summary":
    ensure => file,
    mode   => 744,
    content => template("systembase_live_dev/hardinfo.sh"),
  }
}
