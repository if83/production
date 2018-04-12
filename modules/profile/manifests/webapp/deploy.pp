# Class: profile::tomcat::proxy defines the configuration of mod_proxy_ajp
# 
#
#
class profile::webapp::deploy {
  $url_rpm      = "http://repo.if083/apps/bugtrckr-0.1-1.x86_64.rpm"

  # Deploy application bugtrckr
  package { 'bugtrckr':
    ensure            => installed,
    provider          => 'rpm',
    source            => "$url_rpm",
    #notify            => Service['tomcat'],
  }

}
