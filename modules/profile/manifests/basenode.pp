class profile::basenode {
  $ssh_user      = 'if083'
  $ssh_group     = 'wheel'
  $ssh_password  = 'derferterela'

  include motd
  include base

  base::ssh_user { $ssh_user:
    ssh_user     => $ssh_user,
    ssh_group    => $ssh_group,
    ssh_password => $ssh_password,
  }

  rsyslog::config {'secure':
    log_name => '/var/log/secure',
    log_tag  => 'sys_',
    app_name => 'secure',
    severity => 'info',}],
  }

  rsyslog::config {'messages':
    log_name => '/var/log/messages',
    log_tag  => 'sys_',
    app_name => 'messages',
    severity => 'info',}],
  }
}
