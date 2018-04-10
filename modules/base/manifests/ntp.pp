class base::ntp (
  $ntp_service = 'ntpd',
){
	# Configure  ntp.conf

	file { 'ntp.conf':
	  path    	=> '/etc/ntp.conf',
	  ensure  	=> file,
	  require 	=> Package['ntp'],
	  source  	=> "puppet:///modules/base/ntp.conf",
	  notify	=> Service['ntp'],
	}
	
	# Start ntp service
	service { 'ntp':
	  name      => $ntp_service,
	  ensure    => running,
	  enable    => true,
	  subscribe => File['ntp.conf'],
	}
}