# Class: base
#
#

class ntp {
	
	# OS parameters for Update and ntp-service
	if $::osfamily == 'RedHat' {
		$ntp_service = 'ntpd'
	}
	elsif $::osfamily == 'Debian' {
		$ntp_service = 'ntp'
	}

	# Start ntp
	package { 'ntp':
		ensure       => installed,
	}	

	# Configure ntp service
	class { 'ntp::config':
		ntp_service	 => $ntp_service,
		require      => Package['ntp'],	
	}
}
