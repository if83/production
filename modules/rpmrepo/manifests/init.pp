# rpmrepo
# ===================
#
# Crete custom rpm repository for project build artifacts
#
# @summary A short summary of the purpose of this class
#
# @example
#   include rpmrepo
class rpmrepo (
  $repo_domain,
  $repo_name,
  $repo_source,
  $repo_dirs = undef,
  $user      = 'root',
  $group     = 'root',
  ) {
  $repo_path = "/var/www/html"

  include rpmrepo::install

  file { $repo_path:
    ensure  => directory,
    mode    => '0755',
    owner   => $user,
    group   => $group,
  }

  $repo_dirs.each |String $repo_dir| {
    file { "${repo_path}/${repo_dir}":
      ensure  => directory,
      mode    => '0755',
      owner   => $user,
      group   => $group,
      recurse => true,
      source  => "file:///${repo_source}",
      notify  => Service['httpd'],
    }

    exec { "repocreate-${repo_dir}":
      subscribe  => Service['httpd'],
      command => "/usr/bin/createrepo --database ${repo_path}/${repo_dir}",
      path    => '/usr/bin',
      creates => "${repo_path}/${repo_dir}/repodata",
      require => Package['createrepo'],
    }
  }
}
