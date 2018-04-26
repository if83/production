# Class: haproxy::log
# ===========================

class profile::haproxy::log {
  $rsyslog 		= '/etc/sysconfig/rsyslog' 

# Configure haproxy.log   

  file {'haproxy_log':
  	ensure 		=> 'file',
  	source 		=> 'puppet:///modules/profile/log.sh',
  	path   		=> '/etc/haproxy/log.sh',
  	owner  		=> 'root',
  	mode   		=> '755',
  }
  
  exec { 'log.sh':
    command   => '/etc/haproxy/log.sh',
    before    => File["$rsyslog"],
    require   => File['/etc/haproxy/log.sh'],
  }

  file { "$rsyslog":
    ensure    => 'file',
    owner     => 'root',
    group     => 'root',
    source    => 'puppet:///modules/profile/rsyslog',
    replace   => true,
    require   => Package['haproxy'],
    notify => Service['haproxy'],
  }
}
