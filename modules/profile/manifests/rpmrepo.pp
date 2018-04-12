class profile::rpmrepo {
  class { 'rpmrepo':
    repo_domain => $facts[hostname],
    repo_name   => 'Our local repopository',
    repo_dirs   => ['soft','apps'],
  }

  include httpd

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
}
