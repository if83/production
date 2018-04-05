# mysql::install
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include mysql::install
class mysql::install {

  {
  if $mysql::mysql_version == "5.7" {
    $mysql_ver="57"
  }
    elsif $mysql::mysql_version == "5.6" {
    $mysql_ver="56"
  } 

  case $::osfamily {
    'RedHat':  {
 	$releasever = "7"
 	$basearch   = $hardwaremodel

 	if $mysql::mysql_distro == "community" {
    $repo_descr = "MySQL $mysql::mysql_version Community Server"
    $repo_url   = "http://repo.mysql.com/yum/mysql-${mysql::mysql_version}-community/el/$releasever/$basearch/"
 	}
}
}

yumrepo { "mysql-repo":
  descr       => $repo_descr,
  enabled     => 1,
  baseurl     => $repo_url,
  gpgcheck    => 0,
}

package { 'mysql-community-server':
  ensure  => present,
  require => Yumrepo['mysql-repo'],
}
}
