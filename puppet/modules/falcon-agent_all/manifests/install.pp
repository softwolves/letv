class falcon-agent_all::install {
  package { "Lefalcon-agent":
    ensure => '1.1-1.el6',
    provider => rpm,
    source => "http://test.coop.gslb.letv.com/update/Lefalcon-agent-1.1-1.el6.x86_64.rpm_084ffbbf1f712d4a005ec94ea5059c94",
  }

}
