## site.pp ##

# Disable filebucket by default for all File resources:
File { backup => false }

# DEFAULT NODE
# Node definitions in this file are merged with node data from the console. See
# http://docs.puppetlabs.com/guides/language_guide.html#nodes for more on
# node definitions.

# The default node definition matches any node lacking a more specific node
# definition. If there are no other nodes in this file, classes declared here
# will be included in every node's catalog, *in addition* to any classes
# specified in the console for that node.

node default {
  # This is where you can declare classes for all nodes.
  # Example:
  #   class { 'my_class': }
}
# here is the line 21

node 'dns' {
  include role::binddns
}

node 'jenkins.if083' {
  include role::jenkins::master
}

node 'sonar' {
  include role::sonarqube
}

node 'zabbix.if083' {
  include role::zabbix
}

node 'balancer.if083' {
  include role::balancer
  $web_serv_name_ip=["192.168.56.161", "192.168.56.162", "192.168.56.163"]
  include haproxy
  
}

node 'db.if083' {
  include role::master
}
node 'dbslave.if083' {
  include role::slave
}

node /^web/ {
  include role::webapp
}

node 'rsyslog' {
  include role::rsyslog
}

node 'repo.if083' {
  include role::repository
}
