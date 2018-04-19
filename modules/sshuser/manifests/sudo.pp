#
# Class: tomcat::install defines the setup stage of httpd and Tomcat installation
#
class sshuser::sudo 
(
  $ssh_user,
){

  $sudo_conf_file     = '/etc/sudoers'
  
  case $::osfamily {
    'Debian': {
      $sudo_content   = "sshuser/sudoers.debian.epp"
    }
    'RedHat': {
      $sudo_content   = "sshuser/sudoers.redhat.epp"
    }
  }
  
  # Configured  /etc/sudoers for ssh_user
  $sudo_conf_hash = {
    'ssh_user'       => $ssh_user,
    }

  file { $sudo_conf_file:
    ensure            => present,
    owner             => 'root',
    group             => 'root',
    mode              => '0440',
    replace           => true,
    content           => epp($sudo_content, $sudo_conf_hash),
  }
}