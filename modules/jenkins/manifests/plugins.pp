# Class: jenkins::plugins
# ===========================
#
# Use it to open ports on severs
#
# @ param dport
#    enter the number of port you wish to open
#
# @example
#    class { 'base::firewall':
#      dport => '80',
#    }


# == Define: base::firewall
#
define jenkins::plugins (
  $plugins = undef,
  ){
  $plugins.each |String $plugin| {
    exec { "install_${plugin}":
      command => "wget http://updates.jenkins-ci.org/latest/${plugin}.hpi",
      path => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
      cwd     => '/var/lib/jenkins/plugins',
      creates => "/var/lib/jenkins/plugins/${plugin}.hpi",
    }
  }
}
