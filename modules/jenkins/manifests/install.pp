# jenkins::install
# ==========================
#
# Install jenkins and jenkins tools
#
#
# @example
#   include jenkins::install
#
class jenkins::install (
  $jenkins_home_dir   = $jenkins::jenkins_home,
  $java_tool_install  = $jenkins::jdk_tool,
  $java_tool_name     = $jenkins::jdk_tool_name,
  $java_tool_url      = $jenkins::jdk_tool_url,
  $java_tool_subdir   = $jenkins::jdk_tool_subdir,
  $maven_tool_install = $jenkins::mvn_tool,
  $maven_tool_name    = $jenkins::mvn_tool_name,
  $maven_tool_url     = $jenkins::mvn_tool_url,
  $maven_tool_subdir  = $jenkins::mvn_tool_subdir,
  $useSecurity        = $jenkins::security,
  $user_name          = $jenkins::user,
  $user_pass          = $jenkins::password,
  ){

  # install custom jenkins rpm package
  package { 'jenkins_war':
    ensure    => installed,
    name      => 'jenkins2',
    provider  => 'yum',
    #subscribe => Service['tomcat'],
    #before    => Exec['wait_for_jenkins_deploy'],
  }

  file { "${jenkins_home_dir}":
    ensure  => directory,
    mode    => '0755',
    owner   => 'tomcat',
    group   => 'tomcat',
    require => Package['jenkins_war'],
  }

  exec { 'wait_for_jenkins_deploy':
    command   => "grep hudson ${jenkins_home_dir}/config.xml",
    path      => '/usr/bin:/bin',
    tries     => 3,
    try_sleep => 60,
    require   => File["${jenkins_home_dir}"]
  }

  file { "${jenkins_home_dir}/config.xml":
    ensure  => file,
    mode    => '0644',
    owner   => 'tomcat',
    group   => 'tomcat',
    content => epp('jenkins/configs/config.xml.epp', {useSecurity => $useSecurity}),
  }

  ### --- TOOLS INSTALLATION PART ---
  #install git
  package { 'git':
    ensure    => installed,
    provider  => 'yum',
  }

  # create folder for groovy scripts
  file { "${jenkins_home_dir}/init.groovy.d":
    ensure  => directory,
    mode    => '0644',
    owner   => 'tomcat',
    group   => 'tomcat',
    require => Exec['wait_for_jenkins_deploy'],
  }

  # install jenkins java tool
  if ($java_tool_install) {
    $java_tool_hash = {
      java_tool_name   => $java_tool_name,
      java_tool_url    => $java_tool_url,
      java_tool_subdir => $java_tool_subdir,
    }

    file { "${jenkins_home_dir}/init.groovy.d/java.groovy":
      ensure  => file,
      mode    => '0744',
      content => epp('jenkins/groovy/java.groovy.epp', $java_tool_hash),
      require => File["${jenkins_home_dir}/init.groovy.d"],
    }
  }

  #install jenkins maven tool
  if ($maven_tool_install) {
    $maven_tool_hash = {
      maven_tool_name   => $maven_tool_name,
      maven_tool_url    => $maven_tool_url,
      maven_tool_subdir => $maven_tool_subdir,
    }

    file { "${jenkins_home_dir}/init.groovy.d/maven.groovy":
      ensure  => file,
      mode    => '0744',
      content => epp('jenkins/groovy/maven.groovy.epp', $maven_tool_hash),
      require => File["${jenkins_home_dir}/init.groovy.d"],
    }
  }
  #create user acount
  $user_hash = {
    user_name => $user_name,
    user_pass => $user_pass,
  }

  file { "${jenkins_home_dir}/init.groovy.d/user.groovy":
    ensure => file,
    mode => '0744',
    content => epp('jenkins/groovy/user.groovy.epp', $user_hash),
    require => File["${jenkins_home_dir}/init.groovy.d"],
  }

}
