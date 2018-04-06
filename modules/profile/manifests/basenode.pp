class profile::basenode {
  $ssh_user      = 'if083'
  $ssh_group     = 'wheel'
  $ssh_password  = 'derferterela'
  $apps = [ {log_name => '/var/log/secure', log_tag  => 'sys_', app_name => 'secure', severity => 'info'},
          {log_name => '/var/log/messages', log_tag  => 'sys_', app_name => 'messages', severity => 'info',}
          ]    

  include motd
  include base

  base::ssh_user { $ssh_user:
    ssh_user     => $ssh_user,
    ssh_group    => $ssh_group,
    ssh_password => $ssh_password,
  }

  $apps.each |$app| {
    $filename = $app[app_name]
    file { "/etc/rsyslog.d/${filename}.conf":
      ensure  => file,
      mode    => '0644',
      owner   => 'root',
      content => template('rsyslog/appslog.conf.erb'),
      notify  => Service['rsyslog'],
    }
  }  
}
