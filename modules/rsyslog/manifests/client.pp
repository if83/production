## when this resource have been called, 
## it's required to define list of hashes <apps>
## which is reliable for gathering of app logs
##  appnamei = {
##    $log_name => 'logname',  path to log file
##    $log_tag  => 'tag',      also uses as prefix for logname
##    $app_name => 'appname',  uses as name forconfig file
##    $severity => 'severity',
##  }
##  apps = [$appname1, $appname2, ... $appnamen]
##
## where <log_name> - path to application logs (/path/to/logs/*.log in cseof multiple logs)
##       <app_name> - tag name for application

class rsyslog::client (

  $log_proto = 'tcp',
  $log_port  = '601',
  $log_serv  = '192.168.56.15',
){
# the <log_serv> value can be defined as an IP address either as a domain name
  $db_host   = 'localhost'
  $db_name   = 'syslog'
  $db_user   = 'rsyslog'
  $db_pass   = 'rsyslog'
# variables below are intended for proper work of .conf template
  $dport     = $log_port
  $hosttype  = 'client'

  
  case $::osfamily {
    'RedHat': {
      case $::operatingsystem {
        'RedHat', 'CentOS': {
          case  versioncmp($::operatingsystemrelease, '7.0') {
            -1: {
              fail('this module supports platform versions from 7.0 up')
            }
            default: { }
          }
        }
        default: { fail("unsupported platform ${::operatingsystem}") }
      }
    }
    default: { fail("unsupported platform ${::osfamily}") }
  }

  file { '/etc/rsyslog.conf':
    ensure  => file,
    mode    => '0644',
    owner   => 'root',
    content => template('rsyslog/rsyslog.conf.erb'),
    notify  => Service['rsyslog'],
  }

  service { 'rsyslog':
    ensure      => running,
    enable      => true,
  }
}
