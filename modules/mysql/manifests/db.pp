# mysql::db
#
# A description of what this defined type does
#
# @summary A short summary of the purpose of this defined type.
#
# @example
#   mysql::db { 'namevar': }
define mysql::db(
  String $database,
  $charset = 'utf8',
  $collate = 'utf8_unicode_ci', 
)
{
include mysql
$r_pass = $mysql::mysql_root_password
Exec {
    path => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
}
exec {"${title}":
  command => "mysql -u root -p'${r_pass}' -e \"CREATE DATABASE ${database} DEFAULT CHARSET = ${charset} COLLATE = ${collate};\"",
  unless  => "mysql -u root -p'${r_pass}' -e \"SHOW DATABASES;\" | grep ${database}",
  require => [Package['mysql-community-server'], Exec['set_root_pwd']],
}
}

#mysql -u root -p"$DATABASE_PASS" -e "CREATE DATABASE bugtrckr DEFAULT CHARSET = utf8 COLLATE = utf8_unicode_ci;"