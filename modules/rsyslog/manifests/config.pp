define rsyslog::config (
  $app_name = 'sys',
  $log_name = undef,
  $log_tag  = 'sys_',
  $severity = 'info',
  $facility = 'local7',
){
  if log_name != undef {
    file { "/etc/rsyslog.d/${app_name}.conf":
      ensure  => file,
      mode    => '0644',
      owner   => 'root',
      content => template('rsyslog/appslog.conf.erb'),
      notify  => Service['rsyslog'],
    }  
  }
}