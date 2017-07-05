class systembase_live::hardinfo{
  file{"/letv/soft/tools/summary":
    ensure => file,
    mode   => 744,
    content => template("systembase_live/hardinfo.sh"),
  }
}
