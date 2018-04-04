# Class: postgres
# ===========================
#  This module uses yet for RedHat family OS only
# Copyright
# ---------
#
# Copyright 2018 oleksdiam
#
class postgres (
  $ensure           = 'installed',
  $version          = '9.6',
  $admin_pass       = 'adminpass',
  $owner            = 'sonar',
  $db_pass          = 'sonar',
  $dbname           = 'sonar',
  $user_host        = 'localhost',
  $source_url       = 'https://download.postgresql.org/pub/repos/',
  $dport            = '5432',
){
  
  $short_vers       = regsubst($version,'(\D)','')
  $pgsql            = "postgresql${short_vers}"
  $psql_pass        = "${admin_pass}"
  $psql_user        = 'postgres'
  $psql_group       = 'postgres'
  $psql_path        = '/usr/bin/psql'

  Exec {
    path => '/usr/bin:/usr/sbin:/bin:/sbin:/usr/local/bin',
  }

  case $::osfamily {
    'RedHat', 'Linux': {
      $uri  = "yum/${version}/redhat/rhel-7-x86_64/pgdg-centos${short_vers}-${version}-3.noarch.rpm"
    }
    default: {fail("Unsupported OS: ${::osfamily}.  Implement me?")}
  }

  exec { 'psql_repo':
    command => "yum -y install ${source_url}${uri}",
    creates => "/etc/yum.repos.d/pgdg-${short_vers}-centos.repo",
    user    => 'root',
  }
  ->
  package { "${pgsql}":
    ensure   => $ensure,
    provider => 'yum',
  }
  ->
  package { "${pgsql}-server":
    ensure   => $ensure,
    provider => 'yum',
  }

  exec { 'initdb':
    command  => "/usr/pgsql-${version}/bin/postgresql${short_vers}-setup initdb",
    creates  => "/var/lib/pgsql/${version}/data/base/",
 }  

  file { "/var/lib/pgsql/${version}/data/pg_hba.conf":
    ensure  => file,
    mode    => '0600',
    content => template('postgres/pg_hba.conf.erb'), 
    notify  => Service["postgresql-${version}"],
  }

  file { "/var/lib/pgsql/${version}/data/postgresql.conf":
    ensure  => file,
    mode    => '0600',
    content => template('postgres/postgresql.conf.erb'),
    notify  => Service["postgresql-${version}"],
  }

  service { "postgresql-${version}":
  	enable      => true,
  	ensure      => running,
  	hasrestart  => true,
  	hasstatus   => true,
  }

  exec { 'alter_postgre':
    command     => "psql -c \"ALTER USER ${psql_user} WITH PASSWORD '${psql_pass}';\"",
    user        => "${psql_user}",
  }

  ->
  exec { 'createuser':
  	command     => "psql -c \"CREATE USER ${owner};\"",
  	user        => "${psql_user}",
    unless      => "psql -c '\\du' | grep '^  *${owner}  *|'",
  }

  ->
  exec { 'createdb':
  	command     => "psql -c \"CREATE DATABASE ${dbname} WITH OWNER = ${owner};\"",
  	user        => "${psql_user}",
  	require     => Exec['createuser'],
    unless      => "psql -c '\\l' | grep '^  *${dbname}  *|'",
  }
  
  ->
  exec { 'alter_owner':
    command     => "psql -c \"ALTER USER ${owner} with encrypted password '${db_pass}';\"",
    user        => "${psql_user}",
  	require     => Exec['createdb'],
  }
}


