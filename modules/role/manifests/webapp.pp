class role::webapp {
    include profile::basenode
    include profile::zabbix::agent

  # Configure webapps
  class { 'profile::tomcat': 
  	docBase             => 'BugTrckr-0.5.0-SNAPSHOT',
  }

  # Deploy application bugtrckr
  $url_rpm      = "http://repo.if083/apps/bugtrckr-0.1-1.x86_64.rpm"
  
  package { 'bugtrckr':
    ensure            => installed,
    provider          => 'rpm',
    source            => "$url_rpm",
    notify            => Service['tomcat'],
  }

  # Configure mod_proxy
  class { 'profile::modproxy':
  }

}
