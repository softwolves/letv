class systembase_front_dev::hardinfo{
  file{"/letv/soft/tools/summary":
    ensure => file,
    mode   => 744,
    content => template("systembase_front_dev/hardinfo.sh"),
  }
}
