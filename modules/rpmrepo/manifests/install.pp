# rpmrepo::install
# ==========================
#
# Install software required to build a repositiry
#
# @summary This class add to node next things:
#  - Apache Web Server
#  - createrepo tool
#
# @example
#   include rpmrepo::install
class rpmrepo::install {
  include httpd

  file { '/var/www/html/repo':
    ensure => directory,
    mode   => '0644',
  }

  firewall::openport {'rpmrepo':
    dports => ['80',],
  }

  $fpm_needs= ['ruby-devel', 'gcc', 'make', 'rpm-build', 'rubygems',]

  package { $fpm_needs:
    ensure => latest,
    before => Exec[gem_update],
  }

  exec { 'gem_update':
    command => 'gem update --system',
    path    => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    before  => Package[fpm],
  }

  package { 'fpm':
    ensure   => installed,
    provider => 'gem',
    #install_options => ['--no-ri', '--no-rdoc'],
  }
}
