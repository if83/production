class profile::jenkins::master {
  $dports          = ['8080']
  $log_proto       = 'tcp'
  $log_port        = '601'
  $log_serv        = '192.168.56.10'
  $user_host       = 'localhost'
  $java_mode       = 'jdk'
  $jenkins_version = '6.7.2'

  # set of apps needs to be logged
  $jenkins = {
    log_name => '/var/log/jenkins/*.log',
    app_name => 'jenkins',
    severity => 'info',
  }
  $apps   = [$jenkins]

  class { 'java8':
    java_se      => $java_mode,
  }
  include jenkins

  base::ssh_user { $ssh_user:
    ssh_user     => $ssh_user,
    ssh_group    => $ssh_group,
    ssh_password => $ssh_password,
  }
  firewall::openport {'jenkins':
    dports       => $dports,
  }
  rsyslog::client { 'app' :
    log_proto    => $log_proto,
    log_port     => $log_port,
    log_serv     => $log_serv,
    apps         => $apps,
  }

}
