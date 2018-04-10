class profile::basenode {

  include motd

# schedule parameters for update
  $period        = 'daily'
  $repeat        = '1'

  class { 'base':
    period       => $period,
    repeat       => $repeat,
  }

# Configure ssh_user
# Defaulf user if083 password if083
  base::ssh_user { 'if083':
    ssh_user     => 'if083',
    ssh_password => 'K7xRO54jYI7Ws',
    key          => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDYas7S4GkDiT8ePqcjEq2byr4Fu9oQwi9XNBbB/+ZKmUu1mKPtd5CwC6qMYPMof50bG9dnwUdN36G6GpBcK82PpmMYndQuGc9Luluhia8gFI/lpXQiPwrw5gjYve4GW/wtT+1GBJ0b5FUeY5pLbGVvgdpyZ39Q4dCXiJEdPjLXM7SWOc7KrnVYpm+D/FqsG1VtUDUs3qnF4EXpNhQGH61yFpwQ52om8dg4bjzgLD1IgoTaUjajWJBdp7SV/8nbakKLrmwkweGQo1jS3xGAe61+KCbpPhPpRvGikllJ5Cgu7d0QypOTl4ySNRGrl1gQpwg5ya148/E9OZ09AGUmPPAJ'
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