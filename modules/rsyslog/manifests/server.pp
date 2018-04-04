# Class: rsyslog
# ===========================
#
# Full description of class rsyslog here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'rsyslog':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2018 oleksdiam
#
# SELinux allows port 601 for syslogd-port_t tcp/udp proto ; port 514 for udp 
#                    & port 6514 tcp/udp proto  for syslog_tls-port_t
#
define rsyslog::server (

  $log_proto   = 'tcp',
  $log_port    = '601',

){
  $dport       = $log_port
  $hosttype    = 'server'
  $log_serv    = 'localhost'
# the <log_serv> value can be defined as an IP address either as a domain name

  Exec {
    path => '/usr/bin:/usr/sbin:/bin:/sbin:/usr/local/bin',
    user => 'root',
  }

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

  exec { 'firewall-port':
    command     => "firewall-cmd --zone=public --add-port=${dport}/${log_proto} --permanent",
    notify      => Exec['firewall_reload'],
  }
  ->
  exec { 'firewall_reload':
    command     => 'firewall-cmd --reload',
    notify      => Service['firewalld'],
  }
  ->
  service { 'firewalld':
    ensure     => running,
    enable     => true,
    hasrestart => true,
  }
}
