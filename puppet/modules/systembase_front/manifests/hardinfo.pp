class systembase_front::hardinfo{
  file{"/letv/soft/tools/summary":
    ensure => file,
    mode   => 744,
    content => template("systembase_front/hardinfo.sh"),
  }
}
