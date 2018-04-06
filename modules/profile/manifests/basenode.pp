class profile::basenode {
  $apps = [ {log_name => '/var/log/secure', log_tag  => 'sys_', app_name => 'secure', severity => 'info'},
          {log_name => '/var/log/messages', log_tag  => 'sys_', app_name => 'messages', severity => 'info',}
          ]    

  include motd
  include base

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
