class zabbix (
  $version = 3.4,
  $osfamily = rhel,
  $osversion = 7,
)
{

  # configure zabbix repo
  # main repo
  yumrepo { 'zabbix':
    enabled  => 1,
    priority => 1,
    baseurl  => "http://repo.zabbix.com/zabbix/${version}/${osfamily}/${osversion}/x86_64/",
    includepkgs => absent,
    exclude     => absent,
    gpgcheck    => 0,
    gpgkey      => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-ZABBIX',
  }
 ->
  # zabbix-nonsupported repo
  yumrepo { 'zabbix-nonsupported':
    enabled  => 1,
    priority => 1,
    baseurl  => "https://repo.zabbix.com/non-supported/${osfamily}/${osversion}/x86_64/",
    gpgcheck    => 0,
    includepkgs => absent,
    exclude     => absent,
    gpgkey      => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-ZABBIX',
  }

}
