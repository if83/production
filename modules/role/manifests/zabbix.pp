class role::zabbix {
  include profile::mysqlserver::master
  include profile::zabbix::server

}
