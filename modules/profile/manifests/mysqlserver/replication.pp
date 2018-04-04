class profile::mysqlserver::replication {
  $mysql_root_password = "a8+?treAvpDa" # My root password
  $mysql_distro        = "community" # Distributive name. For now community only 
  $mysql_version       = "5.7" # Provide the Mysql Version. You can set 5.7 or 5.6
  $mysql_serverid      = "2" # Provide the Server ID = 1.2.3.... etc
  $datadir             = "/var/lib/mysql" # can also be defined under my.cnf
  $port                = ['3306'] # can also be defined under my.cnf
  $bind_address        = "0.0.0.0"  # can also be defined under my.cnf
  $replica_user        = "replication" # For master, what is the replication account
  $replica_password    = "Pr0m3Teus!" # Replication User password
  $is_slave            = true  # True if the node is slave
  $master_ip           = "192.168.56.150" # The IP Address of the master in case this is a slave
  $master_port         = "3306" # The port where the master is listening to

include stdlib

firewall::openport {'mysqlslave':
    dports => $port,
  }

class { 'mysql':
  mysql_root_password => $mysql_root_password,
  mysql_distro        => $mysql_distro,
  mysql_version       => $mysql_version,
  mysql_serverid      => $mysql_serverid,
  bind_address        => $bind_address,
}
  if $is_slave {
    validate_ip_address($master_ip)  # IP Address must be set to identify the master
    $cmd_change_master = join(["CHANGE MASTER TO MASTER_HOST","\'${master_ip}\',MASTER_PORT","${master_port},MASTER_USER","\'${replica_user}\',MASTER_PASSWORD","\'${replica_password}\';"], "=") 
    $cmd_start_slave   = "START SLAVE;"
    exec { 'set_master_params':
      command => "mysql --defaults-extra-file=/root/.my.cnf --execute=\"${cmd_change_master}${cmd_start_slave}\"",
      require => Class['mysql'],
      path    => ["/usr/local/sbin","/usr/local/bin","/sbin","/bin","/usr/sbin","/usr/bin","/opt/puppetlabs/bin","/root/bin"],
      unless  => "grep ${master_ip} $datadir/master.info && grep ${master_port} $datadir/master.info && grep -w ${replica_user} $datadir/master.info && grep -w ${replica_password} $datadir/master.info",
    }
  }
}