class profile::rsyslog {
  $dports        = ['601']

  $node_s    = generate("/bin/bash", "-c", "/bin/awk 'NF > 0 {print \$1}' /etc/puppetlabs/code/environments/production/modules/profile/templates/fwd_zone_list.erb")
  $node_list = split($node_s, "\n")

  class { 'rsyslog::server':
    log_proto   => 'tcp',
    log_port    => '601',
  }

  class { 'rsyslog::elksender':
    severity   => 'info',
    facility   => 'local7',
    dnsfile    => 'profile/fwd_zone_list.erb',
    elk_server => 'elk',
    elkport    => '2000',
    elkproto   => 'tcp',
    node_list  => $node_list,
    # node_list  => [dns, sonar, web1, web2, web3, jenkins, zabbix, db, dbslave, balanser, gitlab, repo],
  }

  firewall::openport {'rsyslog':
    dports       => $dports,
  }
}