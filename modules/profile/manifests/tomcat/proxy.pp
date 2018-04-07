# Class: profile::tomcat::proxy defines the configuration of mod_proxy_ajp
# 
#
#
class profile::tomcat::proxy
(
  # config variables for mod_proxy
  $dns_name,
){
  # config variables for mod_proxy
  $proxy_conf_file      = '/etc/httpd/conf.d/tomcat.conf'

# Configure /usr/sbin/setsebool httpd_can_network_connect true
  exec { 'setsebool':
    command => 'setsebool -P httpd_can_network_connect=1',
    path    => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    require => Package['httpd'],
  }

# Configured  /etc/httpd/conf.d/tomcat.conf for dns_name and AJP13 protocol
  $proxy_conf_hash = {
    'dns_name'        => $dns_name,
  }

  file { $proxy_conf_file:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0664',
    content => epp('profile/proxy.conf.epp', $proxy_conf_hash),
    notify  => Service['httpd'],
  }
}
