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
class rsyslog (

  $log_proto = 'udp',
  $dport     = '514',
){

  # Exec {
  #   path => '/usr/bin:/usr/sbin:/bin:/sbin:/usr/local/bin',
  # 	user => 'root',
  # }

  # service { 'rsyslog':
  # 	enable      => true,
  # 	ensure      => running,
  # 	#hasrestart => true,
  # 	#hasstatus  => true,
  # 	#require    => Class["config"],
  # }

}
