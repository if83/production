# jenkins
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include jenkins
class jenkins (
  $repo_url = 'https://pkg.jenkins.io/redhat-stable',
  $key_url  = 'https://pkg.jenkins.io/redhat-stable/jenkins.io.key',
  $dports   = ['8080', '9000'],
  $plugins  = ['sonar', 'maven-plugin', 'jquery']
  ){

  include jenkins::install
}
