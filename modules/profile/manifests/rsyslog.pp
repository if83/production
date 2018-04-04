class profile::rsyslog {
  $ssh_user      = 'if083'
  $ssh_group     = 'wheel'
  $ssh_password  = 'derferterela'
  $dports        = ['601']

  base::ssh_user { $ssh_user:
    ssh_user     => $ssh_user,
    ssh_group    => $ssh_group,
    ssh_password => $ssh_password,
  }

  class { 'rsyslog::server':
    log_proto   => 'tcp',
    log_port    => '601',
  }

  firewall::openport {'rsyslog':
    dports       => $dports,
  }
}