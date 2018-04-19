define sshuser (
    $ssh_user     = 'admin',
    $key          = file('profile/default.pub'),
){
  # Choose sudo group for ssh_user
  if $::osfamily == 'RedHat' {
    $ssh_group  = 'wheel'
  }
  elsif $::osfamily == 'Debian' {
    $ssh_group  = 'sudo'
  }

  # Configure  ssh_authorized_key
  $ssh          = "/home/${ssh_user}/.ssh"
  user { "$ssh_user":
    ensure      => present,
    name        => $ssh_user,
    groups      => $ssh_group,
    shell       => "/bin/bash",
    managehome  => true,    
  }

  file { "$ssh":
    ensure      => directory,
    owner       => $ssh_user,
    group       => $ssh_group,
    mode        => '0700',
    require     => User["$ssh_user"],
  }

  ssh_authorized_key { "${ssh_user}@$fqdn":
    ensure      => present,
    user        => $ssh_user,
    type        => 'ssh-rsa',
    key         => $key,
    require     => File["$ssh"],    
  } 

# Configure sudo user
  class { 'sshuser::sudo':
    ssh_user    => $ssh_user,
  }
}