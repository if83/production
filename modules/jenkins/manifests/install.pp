# jenkins::install
# ==========================
#
# Install jenkins
#
# @summary This class add to node next things:
#  - Apache Web Server
#  - createrepo tool
#
# @example
#   include jenkins::install
#
class jenkins::install {
  yumrepo { 'jenkins':
    ensure   => 'present',
    name     => 'jenkins',
    baseurl  => "${jenkins::repo_url}",
    gpgcheck => '1',
    before   => Exec[add_gpg_key],
  }

  exec { 'add_gpg_key' :
    path     => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
    command  => "rpm --import ${jenkins::key_url}",
    before   => Package[jenk_inst],
    notify   => Package[jenk_inst],
  }

  package { 'jenk_inst':
    name     => 'jenkins',
    ensure   => installed,
    provider => 'yum',
    notify   => Service[jenkins],
  }

  jenkins::plugins {'default':
    notify   => Service[jenkins],
    plugins  => $jenkins::plugins,
  }

  service { 'jenkins':
    ensure     => running,
    name       => 'jenkins',
    hasrestart => true,
    hasstatus  => true,
    enable     => true,
  }
}
