class profile::tomcat (  
    $dports         = ['80', '8080'],
    $ssh_user       = 'if083',
    $ssh_group      = 'wheel',
    $ssh_password   = 'derferterela',
) {

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

  exec { 'setenforce':
    command         => "setenforce 0",
    path            => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    require         => Service['firewalld'],
  }
}
