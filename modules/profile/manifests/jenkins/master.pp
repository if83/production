class profile::jenkins::master {

  # == Class: java8
  #
  class { 'java8':
    version_major => '172',
    local_repo    => 'true',
    local_source  => 'http://repo.if083/soft/',
  }

  include httpd
  include firewall

  # Configure tomcat
    class { 'tomcat':
      tomcat_version      => '7.0.76-3.el7_4',
      dns_name            => $facts['networking']['fqdn'],
      man_user            => 'manager',
      password            => 'manager',
      java_home           => '/usr/java/default/',
      java_heap           => '1024m',
    }

  # Configure mod_proxy
  #  class { 'profile::jenkins::proxy':
  #  }

  # Configure rsyslog
    class { 'rsyslog::client':
    }

  # Add sending logs from tomcat rsyslog
    rsyslog::config { 'tomcat_jenkins':
      log_name            => '/var/log/tomcat/*',
      log_tag             => 'tomcat_jenkins_',
      app_name            => 'tomcat_jenkins',
      severity            => 'info',
    }

  # Configure firewall
    firewall::openport { 'tomcat':
      dports              => ['80', '8080'],
    }

  # Configure selinux
    exec { 'setenforce':
      command             => 'setenforce 0',
      path                => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
      require             => Service['firewalld'],
    }
  # Configure repo
  #  rpmrepo::repocfg {'apps':
  #    reponame => "Our application build repository",
  #    url      => "http://repo.if083",
  #    subpath  => "apps"
  #  }

  class { 'jenkins':
    jenkins_home    => '/usr/share/tomcat/.jenkins',
    jdk_tool        => 'true',
    jdk_tool_name   => 'jdk8',
    jdk_tool_url    => 'http://repo.if083/soft/jdk-8u172-linux-x64.tar.gz',
    jdk_tool_subdir => 'jdk1.8.0_172',
    mvn_tool        => 'true',
    mvn_tool_name   => 'maven3',
    mvn_tool_url    => 'http://repo.if083/soft/apache-maven-3.5.3-bin.tar.gz',
    mvn_tool_subdir => 'apache-maven-3.5.3',
    user            => 'admin',
    password        => 'admin',
    require         => Service['tomcat'],
  }

  #add job
  jenkins::job { 'bugTrckr_app':
    notify     => Service['tomcat'],
    job_name   => 'bugTrckr',
    user       => 'admin',
    repoOwner  => 'if83',
    repository => 'bugTrckr',
    interval   => '120000',
  }

  #install plugins from list in modules/profile/files/plugins.txt
  class { 'jenkins::plugins':
    plugin_repo_url  => 'http://repo.if083/soft/jenkins/plugins/',
    plugin_list_file => 'puppet:///modules/profile/plugins.txt',
  }

  # Add sending logs from tomcat rsyslog
  rsyslog::config { 'jenkins':
    log_name            => '/usr/share/tomcat/.jenkins/log/tasks',
    log_tag             => 'jenkins_',
    app_name            => 'jenkins',
    severity            => 'info',
  }

  # Add fpm tool to create packages
  # include fpm
  class {'profile::modproxy':
    proxy_template => "profile/jenkins.conf.epp",
  }
}
