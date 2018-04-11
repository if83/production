class zabbix::server (
  $dbhost = 'db.if083',
  $dbname = 'zabbix',
  $dbuser = 'zabbix',
  $dbpassword = '3a66ikc_DB',
  $timezone = 'Europe/Kiev',
)
{
  require zabbix

  package { 'zabbix-server-mysql':
    ensure   => installed,
    provider => 'yum',
  }

  package { 'zabbix-web-mysql':
    ensure   => installed,
    provider => 'yum',
    require  => Package['zabbix-server-mysql'],

  }



  file { "/etc/zabbix/zabbix_server.conf":
    ensure  => file,
    content => template('zabbix/zabbix_server.conf.erb'),
    owner   => 'zabbix',
    group   => 'zabbix',
    require => Package['zabbix-web-mysql'],
    mode    => '0666',
  }

  file { "/etc/httpd/conf.d/zabbix.conf":
    ensure  => file,
    content => template('zabbix/zabbix.conf.erb'),
    notify  => Service['httpd'],
    mode    => '0664',
  }

  file {'/opt/db_init.sh':
    ensure  => 'file',
    content => template('zabbix/db_init.sh.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0755', # Use 0700 if it is sensitive
    notify  => Exec['db_init'],
  }
 ->
  exec { 'db_init':
    command => "/bin/bash -c '/opt/db_init.sh'",
    creates => '/var/log/zabbix/zabbix_server.log',
  }
  
  file {'/etc/zabbix/web/zabbix.conf.php':
    ensure  => file,
    content => template('zabbix/zabbix.conf.php.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0664',
  }

  #selinux crutch =)
  package { 'policycoreutils-python':
    ensure   => installed,
    require => Package['zabbix-server-mysql'],
  }
 ->
  file {'/opt/selinux_zbx_server.sh':
    ensure  => 'file',
    content => template('zabbix/selinux_zbx_server.sh.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0755', # Use 0700 if it is sensitive
    notify  => Exec['selinux'],
    require => Package['policycoreutils-python'],
  }
 ->
  exec { 'selinux':
    command => "/bin/bash -c '/opt/selinux_zbx_server.sh'",
    notify  => Service['httpd'],
  }
  


  service { 'zabbix-server':
    ensure  => running,
    require => File['/opt/selinux_zbx_server.sh'],
  }
  

}
