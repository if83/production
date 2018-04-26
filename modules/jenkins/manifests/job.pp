# == Define: jenkins::job
#


define jenkins::job (
  $job_name,
  $user,
  $repoOwner,
  $repository,
  $interval,
  ) {
  $url = $jenkins::jenkins_url

  $jobconf_hash = {
    user       => $user,
    repoOwner  => $repoOwner,
    repository => $repository,
    interval   => $interval,
  }

  file { "${jenkins::jenkins_home}/jobs/${job_name}":
    ensure  => directory,
    mode    => '0644',
    owner   => 'tomcat',
    group   => 'tomcat',
  }

  file { "${jenkins::jenkins_home}/jobs/${job_name}/config.xml":
    ensure  => file,
    mode    => '0644',
    owner   => 'tomcat',
    group   => 'tomcat',
    content => epp('jenkins/jobs/simplejob.xml.epp', $jobconf_hash),
    require => File["${jenkins::jenkins_home}/jobs/${job_name}"],
  }
}
