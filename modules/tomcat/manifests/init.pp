# Class: tomcat
#
# The tomcat module allows Puppet to install Apache Tomcat7 and  mod_proxy_ajp
#
#
#
class tomcat
(

# Appication variables
  $tomcat_version     = latest,
  $dns_name           = 'example.local',
  $docBase            = 'sample',
  $man_user           = 'admin',
  $password           = 'admin',

# Tomcat variables

  $java_home          = '/usr/java/default/jre',
  $java_heap          = '512m',
){
  # Install tomcat
  class { 'tomcat::install':
    tomcat_version    => $tomcat_version,
  }

# Сonfig default variables for tomcat
  $catalina_home      = '/usr/share/tomcat'
  $confdir            = "$catalina_home/conf"
  $tomcat_conf_file   = "$confdir/tomcat.conf"
  $server_conf_file   = "$confdir/server.xml"
  $users_conf_file    = "$confdir/tomcat-users.xml"
  $appdir             = "$catalina_home/webapps/$docBase"

# Configured  /etc/tomcat/tomcat.conf for JAVA_HOME="/usr/java/jdk1.8.0_162/jre"
  $tomcat_conf_hash = {
    'java_path'       => $java_home,
    'java_heap'       => $java_heap,
  }
  file { $tomcat_conf_file:
    owner             => 'root',
    group             => 'root',
    mode              => '0664',
    content           => epp('tomcat/tomcat.conf.epp', $tomcat_conf_hash),
    notify            => Service['tomcat'],
  }

# Configured  /etc/tomcat/server.xml for docBase and dns_name
  $server_conf_hash = {
    'dns_name'        => $dns_name,
    'appdir'          => $appdir,
  }

  file { $server_conf_file:
    owner             => 'root',
    group             => 'root',
    mode              => '0664',
    content           => epp('tomcat/server.conf.epp', $server_conf_hash),
    notify            => Service['tomcat'],
  }

  # Configured  /etc/tomcat/tomcat-users.xml for user and password
  $users_conf_hash = {
    'user_name'       => $man_user,
    'password'        => $password,
  }

  file { $users_conf_file:
    owner             => 'root',
    group             => 'root',
    mode              => '0664',
    content           => epp('tomcat/users.conf.epp', $users_conf_hash),
    notify            => Service['tomcat'],
  }



  # Start tomcat


  service { 'tomcat':
     enable           => true,
     ensure           => running,
     require          => File["$users_conf_file"],
  }
}
