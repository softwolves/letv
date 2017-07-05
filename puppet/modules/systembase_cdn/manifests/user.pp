class systembase_cdn::user {
  user { "zabbix":
    ensure   => "present",
    comment  => 'zabbix',
    home     => '/usr/local/zabbix',
    password => '$6$ASQy2Rwx$E38yd.WdG9uFxp7Hh3XOB5XDGaduhVqexx6W3cd.KNMV.FO4FXIM2fvmGC6hLIMlNza4yByuw3q1r6AiADKVE.',
    shell    => '/bin/bash',

  }
}
