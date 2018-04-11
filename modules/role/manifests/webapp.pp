class role::webapp {
    include profile::basenode
    include profile::webapp::tomcat
    include profile::zabbix::agent
}
