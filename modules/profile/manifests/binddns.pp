class profile::binddns {
  
  $dports        = ['53']

  class { 'binddns':
  }

  class {'rsyslog::client':
  }

  rsyslog::config {'binddns':
    log_name => '/var/log/named/*',
    log_tag  => 'bind_',
    app_name => 'bind',
    severity => 'info',
  }

  firewall::openport {'tcpdns':
    dports       => $dports,
    dproto       => 'tcp',
  }
  firewall::openport {'udpdns':
    dports       => $dports,
    dproto       => 'udp',
  }
}