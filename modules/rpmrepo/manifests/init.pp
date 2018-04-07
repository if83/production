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
  $repo_dirs = undef,
  $user      = 'root',
  $group     = 'root',
  $port      = ['80'],

  ) {
  $repo_path = "/var/www/html/"

  include rpmrepo::install
  include httpd

  firewall::openport {'rpmrepo':
    dports => $port,
  }

  file { $repo_path:
    ensure => directory,
    mode   => '0755',
    owner  => $user,
    group  => $group,
  }

  $repo_dirs.each |String $repo_dir| {
    file { "$repo_path${repo_dir}":
      ensure => directory,
      mode   => '0755',
      owner  => $user,
      group  => $group,
    }
  }
}
