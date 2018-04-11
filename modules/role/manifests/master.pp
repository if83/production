# Class: name
#
#
class role::master {
	include profile::mysqlserver::master
	include profile::mysqlserver::users
	# resources
}
