class profile::rpmrepo {
  include httpd

  class { 'rpmrepo':
    repo_domain => $facts[hostname],
    repo_name   => 'Our local repopository',
    repo_dirs   => ['soft'],
    repo_source => '/vagrant/repo'
  }



  httpd::vhost { 'repo':
    port          => '80',
    document_root => '/var/www/html',
    user          => 'root',
    group         => 'root',
  }

  firewall::openport {'rpmrepo':
    dports => ['80'],
  }

  rpmrepo::updaterepo { 'soft':
    repo_dir    => "/var/www/html/soft",
    update_min  => '15',
    update_hour => '21',
  }

  rpmrepo::updaterepo { 'apps':
    repo_dir    => "/var/www/html/apps",
    update_min  => '*/1',
  }

  class { 'rsyslog::client':
  }
  rsyslog::config { 'repository':
    log_name            => '/var/log/httpd/*',
    log_tag             => 'repo_',
    app_name            => 'repo',
    severity            => 'info',
  }
}
