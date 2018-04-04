# mysql::rootpass
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include mysql::rootpass
class mysql::rootpass {

$root_pass     = $mysql::mysql_root_password
$old_root_pass = "\$(grep 'temporary password' /var/log/mysqld.log| awk '{print \$11}')"

if $root_pass == undef {
   $root_pass = $old_root_password   
}

exec { 'set_root_pwd':
  command   => "mysqladmin -u root --password=${old_root_pass} password '${root_pass}'",
  logoutput => true,
  unless    => "mysqladmin -u root -p'${root_pass}' status > /dev/null",
  path => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
}
}