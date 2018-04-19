class profile::tomcat (
  $docBase,
){

  include java8
  include httpd
  include firewall

# Appication variables
  $tomcat_version       = '7.0.76-3.el7_4'
  $dns_name             = $facts['networking']['fqdn']
  $man_user             = 'manager'
  $password             = 'manager'

# tomcat variables
  $java_home            = '/usr/java/default/jre'
  $java_heap            = '256m'

# firewall variables
  $dports               = ['80', '8080']

# Configure tomcat
  class { 'tomcat':
    tomcat_version      => $tomcat_version,
    dns_name            => $dns_name,
    docBase             => $docBase,
    man_user            => $man_user,
    password            => $password,
    java_home           => $java_home,
    java_heap           => $java_heap,
  }

# Configure rsyslog
  class { 'rsyslog::client':
  }
  rsyslog::config { 'tomcat':
    log_name            => '/var/log/tomcat/*',
    log_tag             => 'tomcat_',
    app_name            => 'tomcat',
    severity            => 'info',
  }

# Configure firewall
  firewall::openport { 'tomcat':
    dports              => $dports,
  }

# Configure selinux
  exec { 'setenforce':
    command             => 'setenforce 0',
    path                => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    require             => Service['firewalld'],
  }
# Configure repo
  rpmrepo::repocfg {'apps':
    reponame => "Our application build repository",
    url      => "http://repo.if083",
    subpath  => "apps"
  }


}
