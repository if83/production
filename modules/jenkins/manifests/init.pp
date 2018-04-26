# jenkins
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include jenkins
class jenkins (
  $jenkins_url     = 'http://192.168.56.170:8080/jenkins', #hardcoded for testing
  $jenkins_home    = '/usr/share/tomcat/.jenkins',
  $jdk_tool        = false,
  $jdk_tool_name   = '',
  $jdk_tool_url    = '',
  $jdk_tool_subdir = '',
  $mvn_tool        = false,
  $mvn_tool_name   = '',
  $mvn_tool_url    = '',
  $mvn_tool_subdir = '',
  $security        = 'false',
  $enableCLI       = 'false',
  $user            = '',
  $password        = '',
  $whereisgit      = 'bin/git'
  ){

  include jenkins::install

  file { "${jenkins_home}/jenkins.CLI.xml":
    ensure  => file,
    mode    => '0644',
    owner   => 'tomcat',
    group   => 'tomcat',
    content => epp('jenkins/configs/jenkins.CLI.xml.epp', {enableCLI => $enableCLI})
  }
}
