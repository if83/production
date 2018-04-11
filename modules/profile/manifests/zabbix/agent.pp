class profile::zabbix::agent {
  $dports        = ['10050']
  
  class { 'zabbix::agent':
    server => 'zabbix.if083',
    aport  => '10050',
  }

  firewall::openport {'zabbixagent':
    dports       => $dports,
  }
}
