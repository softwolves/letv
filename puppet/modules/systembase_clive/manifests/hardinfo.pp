class systembase_clive::hardinfo{
  file{"/letv/soft/tools/summary":
    ensure => file,
    mode   => 744,
    content => template("systembase_clive/hardinfo.sh"),
  }
}
