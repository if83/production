# mysql
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include mysql
class mysql (
	$mysql_root_password = undef,
	$mysql_distro        = "community",
	$mysql_version       = "5.7",
	$mysql_serverid      = undef,
  $bind_address        = "0.0.0.0"
#	$ensure              = "running",
)

{
  if $mysql::mysql_version == "5.7" {
    $mysql_ver="57"
  }
    elsif $mysql::mysql_version == "5.6" {
    $mysql_ver="56"
  }    
 
  include mysql::install
  include mysql::configure
  include mysql::service
  include mysql::rootpass
}
