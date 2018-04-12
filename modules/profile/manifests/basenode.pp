class profile::basenode {

  include motd
  
# schedule parameters for update
  class { 'base':
    period       => 'daily',
    repeat       => '1',
  }

  rpmrepo::repocfg {'soft':
    reponame => "Our Soft",
    url      => "http://repo.if083",
    subpath  => "soft"
  }
# Configure ssh_user
  base::ssh_user { 'if083':
    ssh_user     => 'if083',
    key          => file('profile/service.pub'),
  }
# Configure rsyslog
  rsyslog::config { 'secure':
    log_name     => '/var/log/secure',
    log_tag      => 'sys_',
    app_name     => 'secure',
    severity     => 'info',
  }

  rsyslog::config { 'messages':
    log_name     => '/var/log/messages',
    log_tag      => 'sys_',
    app_name     => 'messages',
    severity     => 'info',
  }
}
