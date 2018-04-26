class rsyslog::elksender (
  $severity   = 'info',
  $facility   = 'local7',
  $dnsfile    = 'profile/fwd_zone_list.erb',
  $elk_server = 'elk',
  $elkport    = '2000',
  $elkproto   = 'tcp',
  $node_list  = [dns],
){
  # $_file_contents = template('profile/fwd_zone_list.erb')
  # $_file_lines    = split($_file_contents, "\n")
  # $node_list = regsubst($_file_lines,'^(\w)\s(*)$','\1')
  # $node_s = generate("/bin/bash", "-c", "/bin/awk 'NF > 0 {print \$1}' /etc/puppetlabs/code/environments/production/modules/profile/templates/fwd_zone_list.erb")
  # $node_list = generate("/bin/bash", "-c", "echo '['\$(cat /etc/puppetlabs/code/environments/production/modules/profile/templates/fwd_zone_list.erb | cut -d ' ' -f1 |tr '\n' ',')']'")
  # $node_list = '['$node_l']'    #\${dnsfile}                             
  # $node_list.each |$node| {

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