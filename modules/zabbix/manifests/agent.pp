class zabbix::agent (
  $server = 'zabbix.if083',
  $aport = '10050',
)
{
  require zabbix

  package { 'zabbix-agent':
    ensure   => installed,
    provider => 'yum',
  }

  #selinux crutch =)
  package { 'policycoreutils-python':
    ensure   => installed,
    require => Package['zabbix-agent'],    
  }
 ->
  file {'/opt/selinux_zbx_agent.sh':
    ensure  => 'file',
    content => template('zabbix/selinux_zbx_agent.sh.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0755', # Use 0700 if it is sensitive
    notify  => Exec['selinux'],
  }
 ->
  exec { 'selinux':
    command => "/bin/bash -c '/opt/selinux_zbx_agent.sh'",
  }



  file { "/etc/zabbix/zabbix_agentd.conf":
    ensure  => file,
    content => template('zabbix/zabbix_agentd.conf.erb'),
    owner   => 'zabbix',
    group   => 'zabbix',
    require => File['/opt/selinux_zbx_agent.sh'],
    mode    => '0666',
    notify  => Service['zabbix-agent'],
  }
 ->
  service {'zabbix-agent':
    ensure  => running,
  }

}
