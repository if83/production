class profile::zabbix::server {
  $dports      = ['80','10050']
  $dbhost      = 'localhost'
  $dbname      = 'zabbix'
  $dbuser      = 'zabbix'
  $dbpassword  = '3a66ikc_DB'
  $timezone    = 'Europe/Kiev'
  
  include httpd

  if $dbhost == 'localhost' {
    mysql::db { 'zabbix_db':
    database => $dbname,
    charset  => 'utf8',
    collate  => 'utf8_unicode_ci',
    }

    mysql::users { 'zabbix_user': 
    table     => $dbname, # GRANT ALL ON ${table}.*
    user      => $dbuser,
    user_pass => $dbpassword,
    host      => '%',
    grant     => 'ALL',
    }
  }
  ->
  class { 'zabbix::server':
    dbhost     => $dbhost,
    dbname     => $dbname,
    dbuser     => $dbuser,
    dbpassword => $dbpassword,
    timezone   => $timezone,
  }

  firewall::openport {'zabbixserver':
    dports       => $dports,
  }
}
