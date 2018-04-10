# Class: base
#
#

class base (
	$period 	 	 = 'weekly',
	$repeat 	 	 = '1'
){
	# schedule parameters for update
	schedule { 'update':
 		period 		 => $period,
	  	repeat   	 => $repeat,
	}

	# OS parameters for Update and ntp-service
	if $::osfamily == 'RedHat' {
		$ntp_service = 'ntpd'
		exec { '/usr/bin/yum -y update':
 	 	schedule 	 => 'update',
 		}
	}
	elsif $::osfamily == 'Debian' {
		$ntp_service = 'ntp'
		exec { '/usr/bin/apt-get -y update':
 	 	schedule 	 => 'update',
 		}
	}

	# Start packages
	$packages = ['tree', 'mc', 'net-tools', 'ntp', 'wget']
	package { $packages:
		ensure       => installed,
	}	
	# Configure ntp service
	class { 'base::ntp':
		ntp_service	 => $ntp_service,
		require      => Package['ntp'],	
	}
}
