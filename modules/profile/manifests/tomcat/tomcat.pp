class profile::tomcat::tomcat
{

  include java8
  include httpd
  include firewall

# Appication variables  
  $tomcat_version       = '7.0.76-3.el7_4'
  $dns_name             = 'bugtrckr.if083'
  $docBase              = 'BugTrckr-0.5.0-SNAPSHOT'
  $man_user             = 'manager'
  $password             = 'manager'

# Tomcat variables  
  $java_home            = '/usr/java/default/jre'
  $java_heap            = '512m'

# rsyslog variables  
  $catalina_log         = '/usr/share/tomcat/logs'
  $httpd_log            = '/var/log/httpd'

# Base variables
  $ssh_user             = 'if083'
  $ssh_group            = 'wheel'
  $ssh_password         = 'tmw'
  $dports               = ['80', '8080']

  class { 'tomcat':
    tomcat_version => $tomcat_version,
    dns_name       => $dns_name,
    docBase        => $docBase,
    man_user       => $man_user,
    password       => $password,
    java_home      => $java_home,
    java_heap      => $java_heap,
  }

# Configure mod_proxy
  class { 'profile::tomcat::proxy':
     dns_name         => $dns_name,
  }

  base::ssh_user { $ssh_user:
    ssh_user     => $ssh_user,
    ssh_password => $ssh_password,
    ssh_group    => $ssh_group,
  }

  firewall::openport { $ssh_user:
    dports              => $dports,
  }

  exec { 'setenforce':
    command => 'setenforce 0',
    path    => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    require => Service['firewalld'],
  }
}
