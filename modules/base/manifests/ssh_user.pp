define base::ssh_user (
    $ssh_user     = 'admin',
    $ssh_password = 'MHFqAb1XfnC8Q',
    $key          = 'AAAAB3NzaC1yc2EAAAADAQABAAABAQCanKzx6z+UImiT3sWUhTrqtWS7WtoyDzv4d48u+f+D0nZlJwP1nXUL3ca32Kz9JbKMLe+MlvZQzW7wJ8m2BVRuKXAIxmLRW3rhYjHgULrSr4OZ46i4Gi/YhDTnyW/28SuOpGD3wlk5cN0rxT0paB/Icoa6nIOjzn+RNJFAvMpblV4O/cVstLJZ2xrZlX+ZoCl3J2OXBkiDc+0xxJU7SEaIkz+WqJceELCKQ76r5GNZXyP+ow6t8egrTJXnBOguo1I8Ssf4UlZ/OnYGsg/17VtmrYulimvZiyJV4ZTmcRbnu1EggQz/2buif8ec2zekhlnjgqN4Ltkwp+D3SYehL0SX'
){
# default user: admin password: admin

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
    password    => $ssh_password,
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
}