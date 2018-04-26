class role::webapp {
    include profile::basenode
    include profile::zabbix::agent

  # Configure webapps
  $dns_name = 'bugtrckr.if083'
  class { 'profile::tomcat': 
  	docBase           => 'BugTrckr-0.5.0-SNAPSHOT',
    dns_name          => "$dns_name",
  }

  # Deploy application bugtrckr
  $url_rpm      = "http://repo.if083/soft/bugtrckr-0.1-1.x86_64.rpm"
  
  package { 'bugtrckr':
    ensure            => installed,
    provider          => 'rpm',
    source            => "$url_rpm",
    notify            => Service['tomcat'],
  }

  # Configure mod_proxy
  class { 'profile::modproxy':
   dns_name          => "$dns_name",
  }    
}
