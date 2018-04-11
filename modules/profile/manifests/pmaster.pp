class profile::pmaster {

  class {'rsyslog::client':
  }

  rsyslog::config {'pmaster':
    log_name => '/var/log/puppetlabs/pupetserver/*.log',
    log_tag  => 'puppet_',
    app_name => 'puppet',
    severity => 'info',
  }

}