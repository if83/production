class role::balancer {
    include profile::basenode
    include profile::zabbix::agent
    include profile::haproxy::install
}
