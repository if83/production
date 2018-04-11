class zabbix {

  # configure zabbix repo
  # insert gpg-key
  file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-ZABBIX':
    ensure => present,
    owner  => root,
    group  => root,
    mode   => '0644',
    source => 'puppet:///modules/zabbix/etc/pki/rpm-gpg/RPM-GPG-KEY-ZABBIX',
  }
 ->
  # main repo
  yumrepo { 'zabbix':
    enabled  => 1,
    priority => 1,
    baseurl  => 'http://repo.zabbix.com/zabbix/3.4/rhel/7/x86_64/',
    gpgcheck => 0,
    includepkgs => absent,
    exclude     => absent,
    gpgkey      => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-ZABBIX',
    require     => File['/etc/pki/rpm-gpg/RPM-GPG-KEY-ZABBIX'],
  }
 ->
  # zabbix-nonsupported repo
  yumrepo { 'zabbix-nonsupported':
    enabled  => 1,
    priority => 1,
    baseurl  => 'https://repo.zabbix.com/non-supported/rhel/7/x86_64/',
    gpgcheck => 0,
    includepkgs => absent,
    exclude     => absent,
    gpgkey      => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-ZABBIX',
    require     => Yumrepo['zabbix'],
  }

}
