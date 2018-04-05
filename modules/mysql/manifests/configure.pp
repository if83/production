# mysql::configure
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include mysql::configure
class mysql::configure
{
  $conf_name = 'mysql-redhat.cnf.erb'
  $serverid  = $mysql::mysql_serverid
  $bind      = $mysql::bind_address
file { $conf_name:
  ensure  => present,
  path    => '/etc/my.cnf',
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
  content => template("mysql/${conf_name}"),
  notify  => Service['mysql']
}
file { '.my.cnf':
  ensure => present,
  path   => '/root/.my.cnf',
  owner  => 'root',
  group  => 'root',
  mode   => '0644',
  source => 'puppet:///modules/mysql/root_pass.cnf',
}
}