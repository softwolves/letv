class systembase_newcdn_dev::hardinfo{
  file{"/letv/soft/tools/summary":
    ensure => file,
    mode   => 744,
    content => template("systembase_newcdn_dev/hardinfo.sh"),
  }
}
