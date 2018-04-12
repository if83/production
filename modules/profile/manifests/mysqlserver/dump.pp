# Class: profile::mysqlserver::dump
#
#
class profile::mysqlserver::dump {

$root_pwd = $mysql::mysql_root_password
file { 'data-dump.sql':
  ensure => present,
  path   => '/tmp/data-dump.sql',
  owner  => 'root',
  group  => 'root',
  mode   => '0644',
  source => 'puppet:///modules/mysql/data-dump.sql',
  require => Class['profile::mysqlserver::users'],
}

exec { 'mysql_import_tables':
  path    => '/usr/bin:/usr/sbin:/bin',
  command => "mysql -u root -p'${root_pwd}' bugtrckr < /tmp/data-dump.sql",
  unless  => "mysql -u root -p'${root_pwd}' -e \"USE bugtrckr;SELECT * FROM Issue;\"",
  require => File['data-dump.sql'],
}
}