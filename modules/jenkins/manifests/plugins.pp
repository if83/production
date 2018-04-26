# Class: jenkins::plugins
# ===========================
#
# Use it to install jenkins plugin listed in file
#
# @ param plugin_repo_url
#    set the path to reposutory with plugins
#
# @ example
#    class { 'jenkins::plugins':
#      plugin_list_file = 'puppet:///modules/profile/plugins.txt'
#      plugin_repo_url  = http://jenkins/,
#    }

class jenkins::plugins (
  $plugin_list_file,
  $plugin_repo_url  = $jenkins::plugin_repo_url,
  $git_path         = $jenkins::whereisgit,
  ){

  $plugin_dir = "${jenkins::jenkins_home}/plugins"
  $url        = $jenkins::jenkins_url

  file { "${plugin_dir}":
    ensure  => directory,
    mode    => '0755',
    owner   => 'tomcat',
    group   => 'tomcat',
    before  => Exec['restart_jenkins'],
  }

  file { '/tmp/plugins.txt':
    ensure => file,
    mode   => '0644',
    source => $plugin_list_file,
  }

  file { '/tmp/install_plugins.sh':
    ensure  => file,
    mode    => '0744',
    content => epp('jenkins/plugins/install_plugins.sh.epp', {
      plugin_repo_url => $plugin_repo_url,
      plugin_dir      => $plugin_dir}
      ),
  }

  exec { 'plugins_install':
    command => '/tmp/install_plugins.sh /tmp/plugins.txt',
    path    => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    require => [ File['/tmp/install_plugins.sh'], File['/tmp/plugins.txt'] ],
  }

  #config git
  file { "${jenkins_home_dir}/hudson.plugins.git.gitTool.xml":
    ensure => file,
    mode => '0644',
    content => epp('jenkins/configs/hudson.plugins.git.gitTool.xml.epp', {git_path => $git_path}),
  }

  #restart jenkins
  exec { 'restart_jenkins':
    command => "java -jar jenkins-cli.jar -s ${url}/ restart",
    path    => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    cwd     => '/usr/share/tomcat/webapps/jenkins/WEB-INF/',
    require => Exec['plugins_install'],
  }
}
