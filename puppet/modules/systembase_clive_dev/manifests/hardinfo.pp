class systembase_clive_dev::hardinfo{
  file{"/letv/soft/tools/summary":
    ensure => file,
    mode   => 744,
    content => template("systembase_clive_dev/hardinfo.sh"),
  }
}
