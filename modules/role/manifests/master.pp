# Class: name
#
#
class role::master {
	include profile::mysqlserver::master
	include profile::mysqlserver::users
	include profile::mysqlserver::dump
	include profile::zabbix::agent
	# resources
}
