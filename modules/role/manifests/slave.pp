# Class: name
#
#
class role::slave {
	include profile::mysqlserver::replication
	include profile::basenode
	# resources
}