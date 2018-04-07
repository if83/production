class profile::basenode {

  include motd
  include base

# Configure ssh_user
  base::ssh_user { 'if083':
    ssh_user     => 'if083',
    ssh_password => 'twm',
    ssh_group    => 'wheel',
  }
# Configure rsyslog
  rsyslog::config {'secure':
    log_name     => '/var/log/secure',
    log_tag      => 'sys_',
    app_name     => 'secure',
    severity     => 'info',
  }

  rsyslog::config {'messages':
    log_name     => '/var/log/messages',
    log_tag      => 'sys_',
    app_name     => 'messages',
    severity     => 'info',
  }
}
