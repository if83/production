# Class: binddns
# ===========================
#  This module uses yet for RedHat family OS only
# Copyright
# ---------
#
# Copyright 2018 oleksdiam
#
class binddns (
  $ensure        = 'installed',
  $ip_pool       = '192.168.56',
  $ip_mask       = '0/24',
  $reverse_pool  = '56.168.192',
  $dnsservername = 'dns',
  $domainname    = 'if083',
  $masterslave   = 'master',
  $dnsserverip   = '2',
){
  
  case $::osfamily {
    'RedHat', 'Linux': {}
    default: {fail("Unsupported OS: ${::osfamily}.  Implement me?")}
  }

  package { 'bind':
    ensure => $ensure,
  }
  package { 'bind-utils':
    ensure => $ensure,
  }

  file { "/var/log/named":
    ensure => directory,
    mode   => '0660',
    owner  => 'named',
    group  => 'named',
  }
  ->
  file { "/var/log/named/default.log":
    ensure => file,
    mode   => '0660',
    owner  => 'named',
    group  => 'named',
  }

  file { "/etc/named.conf":
    ensure => file,
    mode   => '0644',
    content => template('binddns/named.conf.erb'),
    notify  => Service['named'],
  }

  file { "/var/named/fwd.${domainname}.db":
    ensure => file,
    mode   => '0644',
    content => template('binddns/fwd.db.erb'),
    notify  => Service['named'],
  }
  file { "/var/named/${reverse_pool}.db":
    ensure => file,
    mode   => '0644',
    content => template('binddns/reverse.db.erb'),
    notify  => Service['named'],
  }

  service { 'named':
    enable      => true,
    ensure      => running,
    hasrestart  => true,
    hasstatus   => true,
  }
}


