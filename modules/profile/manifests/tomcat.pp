class profile::tomcat (  
    $dports         = ['80', '8080', '8080'],
    $ssh_user       = 'if083',
    $ssh_group      = 'wheel',
    $ssh_password   = 'derferterela',
) {

  $tomcat = {
    log_name => '/var/log/tomcat/*.log',
    app_name => 'tomcat',
    severity => 'info',
  }
  $httpd = {
    log_name => '/var/log/httpd/*.log',
    app_name => 'httpd',
    severity => 'info',
  }
  $apps   = [$tomcat, $httpd]
  include java8
  include tomcat
  include firewall

  base::ssh_user { $ssh_user:
    ssh_user        => $ssh_user,
    ssh_password    => $ssh_password,
    ssh_group       => $ssh_group,
  }
  firewall::openport {'tomcat':
    dports          => $dports,
  }
  
  rsyslog::client { 'app' :
    log_proto    => $log_proto,
    log_port     => $log_port,
    log_serv     => $log_serv,
    apps         => $apps,
  }


  exec { 'setenforce':
    command         => "setenforce 0",
    path            => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    require         => Service['firewalld'],
  }
}
