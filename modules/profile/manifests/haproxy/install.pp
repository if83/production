class profile::haproxy::install {

include firewall
#include haproxy
  
# Configure firewall
  $dports               = ['80', '8080', '443']
  
  firewall::openport { 'haproxy':
    dports              => $dports,
  } 

# Configure rsyslog
  class { 'rsyslog::client':
  } ->

# Configure haproxy log
  class { 'profile::haproxy::log':
  } 

  rsyslog::config { 'haproxy':
    log_name            => '/var/log/haproxy.log',
    log_tag             => 'haproxy_',
    app_name            => 'haproxy',
    severity            => 'info',
    notify              => Service['haproxy'],
  }
}