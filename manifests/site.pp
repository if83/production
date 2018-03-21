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
# here is the line 23


node 'jenkins.local' {
  include role::jenkins::master
  #include maven
}

node 'sonar' {

  class { 'java8':
    java_se       => 'jdk',
  }

  class { 'postgres':
    user_host     => 'localhost',
  }

  class { 'sonarqube':
    db_provider => 'psql',
    db_host     => 'localhost',
  }

}

node 'zabbix' {
  include zabbixsrv
}
node 'db'{
  include zabbixagent
}

node 'balancer' {
  $web_serv_name_ip=["web1 192.168.56.161", "web2 192.168.56.162"]
  include haproxy
}

node 'mysqlmaster.dev' {
  $serverid="1"
  include roles::master
}
node 'mysqlslave.dev' {
  $serverid="2"
  include roles::slave
}


node /^web/ {
  include role::wb
}
