class profile::sonarqube {

  $ssh_user      = 'if083'
  $ssh_group     = 'wheel'
  $ssh_password  = 'derferterela'
  $dports        = ['9000','5432']
  $user_host     = 'localhost'
  $java_mode     = 'jdk'
  $db_provider   = 'psql'
  $admin_pass    = 'N3WP@55'
  $db_host       = 'localhost'
  $sonar_version = '6.7.2'


  base::ssh_user { $ssh_user:
    ssh_user     => $ssh_user,
    ssh_group    => $ssh_group,
    ssh_password => $ssh_password,
  }
  firewall::openport {'sonar':
    dports       => $dports,
  }

  class { 'postgres':
    admin_pass   => $admin_pass,
    user_host    => $user_host,
  }
  class { 'java8':
    java_se      => $java_mode,
  }
  class { 'sonarqube':
    version      => $sonar_version,
    db_provider  => $db_provider,
    db_host      => $db_host,
  }
}