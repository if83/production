class profile::zabbix::server {
  $dports      = ['80','10050']
  
  include httpd

  class { 'zabbix::server':
    dbhost     => 'db.if083',
    dbname     => 'zabbix',
    dbuser     => 'zabbix',
    dbpassword => '3a66ikc_DB',
    timezone   => 'Europe/Kiev',
  }

  firewall::openport {'zabbixserver':
    dports       => $dports,
  }
}
