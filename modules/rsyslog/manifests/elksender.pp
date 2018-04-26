class rsyslog::elksender (
  $severity   = 'info',
  $facility   = 'local7',
  $dnsfile    = 'profile/fwd_zone_list.erb',
  $elk_server = 'elk',
  $elkport    = '2000',
  $elkproto   = 'tcp',
  $node_list  = [dns],
){
  
  $log_name = "/var/log/remote/${node}/*"
  $log_tag  = "${node}"

  file { "/etc/rsyslog.d/elksender.conf":
    ensure  => file,
    mode    => '0644',
    owner   => 'root',
    content => template('rsyslog/elk.fwd.conf.erb'),
    notify  => Service['rsyslog'],
  }
}