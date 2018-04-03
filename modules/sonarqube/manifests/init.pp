# == Class: sonarqube
#
class sonarqube (
  $version          = '6.7.2',
  $user             = 'sonar',
  $group            = 'sonar',
  $sys_user         = true,
  $user_home        = '/var/local/sonar',
  $service          = 'sonar',
  $inst_root        = '/usr/local',
  # set undef value of <dport> when use external firewall module
  $dport            = 9000,
  $source_url       = 'https://sonarsource.bintray.com/Distribution/sonarqube',
  $coockies         = '--no-check-certificate',
  $source_dir       = '/usr/local/src',
  $arch             = $sonarqube::params::arch,
  # Connection strings values
  # values allowed for <db_provider> are: 'embedded' , 'mysql' , 'psql' , 'oracle' , 'mssql_ms' , 'mssql_sql'
  # in case of "embedded" <db_provider> sets, the <db_host> parameter going to be ignored
  $db_provider      = 'embedded',
  $db_host          = 'localhost',
  $db_user          = 'sonar',
  $db_pass          = 'sonar',
  $jdbc             = {
    max_active                        => '50',
    max_idle                          => '5',
    min_idle                          => '2',
    max_wait                          => '5000',
    min_evictable_idle_time_millis    => '600000',
    time_between_eviction_runs_millis => '30000',
  },
) inherits sonarqube::params {

  validate_absolute_path($source_dir)

  $package_name   = 'sonarqube'
  $zipname        = "${package_name}-${version}.zip"
  $ziproute       = "${source_dir}/${zipname}"
  $installdir = "${inst_root}/${service}"
  # $extensions_dir = "${user_home}/extensions"
  # $plugin_dir = "${extensions_dir}/plugins"

  $script = "${installdir}/bin/${arch}/sonar.sh"
  $pid_d  = "${installdir}/bin/${arch}/./SonarQube.pid"

  Exec {
    path => '/usr/bin:/usr/sbin:/bin:/sbin:/usr/local/bin',
  }
  File {
    owner => "${user}",
    group => "${group}",
  }

  package { 'wget':
    ensure => installed,
    before => Exec['download-sonar'],
  }

  group { "${group}":
    ensure => present,
    system => $sys_user,
  }
  ->
  user { "${user}":
    ensure     => present,
    home       => $user_home,
    gid        => $group,
    managehome => true,
    system     => $sys_user,
  }
  ->
  exec { 'download-sonar':
    command      => "wget ${coockies} ${source_url}/${zipname} -O ${ziproute} ",
    cwd       => "${source_dir}",
    creates   => "${ziproute}",
  }

  package { 'unzip':
    ensure => present,
    before => Exec['untar'],
  }

  # ===== Install SonarQube =====
  exec { 'untar':
    command => "unzip -o ${ziproute} -d ${inst_root} && chown -R ${user}:${group} ${inst_root}/${package_name}-${version} && chown -R ${user}:${group} ${user_home}",
    creates => "${inst_root}/${package_name}-${version}/bin",
    # notify  => Service['sonarqube'],
  }
  ->
  file { "${installdir}":
    ensure => link,
    target => "${inst_root}/${package_name}-${version}",
    notify => Service['sonarqube'],
  }
  ->
   file { "/etc/init.d/${service}":
    ensure => link,
    target => $script,
  }
  ->
  # Sonar configuration files
  file { "${installdir}/conf/sonar.properties":
    ensure  => file,
    content => template('sonarqube/sonar.properties.erb'),
    require => Exec['untar'],
    notify  => Service['sonarqube'],
    mode    => '0664',
  }

  ->
  file { "/etc/systemd/system/sonar.service":
    ensure  => file,
    content => template('sonarqube/sonar.service.erb'),
    require => Exec['untar'],
    notify  => Service['sonarqube'],
    mode    => '0664',
  }

  ->
  file { "/etc/sysctl.conf":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    content => template('sonarqube/sysctl.conf.erb'),
    require => Exec['untar'],
    mode    => '0664',
    notify  => Service['sonarqube'],
  }

  ->
  file { "/etc/security/limits.conf":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    content => template('sonarqube/limits.conf.erb'),
    # require => Exec['untar'],
    notify  => Service['sonarqube'],
    mode    => '0664',
  }

# apply system limits for current session
  ->
  exec { 'lims':
    command      => "bash -c 'ulimit -n 65536' && bash -c 'ulimit -u 2048'",
#    user         => "${user}",
    notify  => Service['sonarqube'],
  }  
# restart sysctl service to apply sysctl.conf file
  ->
  exec { 'sys_ctl':
    command => "sysctl -p/etc/sysctl.conf",
    creates => '/etc/sysctl.conf',
  }

  ->
  service { 'sonarqube':
    ensure     => running,
    name       => "${service}",
    hasrestart => true,
    hasstatus  => true,
    enable     => true,
    # require    => File["/etc/init.d/${service}"],
  }

  # if $dport != undef {
  #   exec { 'firewall-cmd':
  #     command => "firewall-cmd --zone=public --add-port=${dport}/tcp --permanent",
  #     notify  => Exec['firewall-reload'],
  #   }
  #   ->
  #   exec { 'firewall-reload':
  #     command => "firewall-cmd --reload",
  #     notify  => Service['firewalld'],
  #   }
  #   ->
  #   service { 'firewalld':
  #     ensure     => running,
  #     enable     => true,
  #     hasrestart => true,
  #   }    
  # }
  
}

