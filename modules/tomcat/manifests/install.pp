#
# Class: tomcat::install defines the setup stage of httpd and Tomcat installation
#
class tomcat::install 
(
  $tomcat_version,
){
  # config variables for tomcat
	
  $packages           = [ 'tomcat-webapps', 'tomcat-admin-webapps']

  # Install 'tomcat', 'tomcat-webapps', 'tomcat-admin-webapps'

  package { 'tomcat':
  	ensure 		        => $tomcat_version,
    }

  package { $packages:
    ensure            => installed,
    require           => Package['tomcat'],
  }

}