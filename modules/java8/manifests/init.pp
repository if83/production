# java8
#
# This class instal JDK8
#
# @summary A short summary of the purpose of this class
#
# @example
#  include java8 {
#    version_major => '161'
#    hash          => '2f38c3b165be4555a1fa6e98c45e0808'
#    java_se       => 'jre',
# }
#http://download.oracle.com/otn-pub/java/jdk/8u171-b11/512cd62ec5174c3487ac17c61aaa89e8/jdk-8u171-linux-x64.rpm
class java8 (
  $java_se       = 'jdk',
  $oracle_url    = 'http://download.oracle.com/otn-pub/java/jdk/',
  $cookie        = '--no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie"',
  $version_major = '172',
  $version_minor = 'b11',
  $hash          = 'a58eab1ec242421181065cdc37240b08',
  $load_dir      = "/tmp/",
  $arch_bit      = $java8::params::arch_bit,
  $local_repo    = 'false',
  $local_source  = undef,
) inherits java8::params {

 # validate java Standard Edition to download
  if $java_se !~ /(jre|jdk)/ {
    fail('Java SE must be either jre or jdk.')
  }
  $pkg       = "${java_se}-8u${version_major}-${arch_bit}.rpm"
  $pkg_path  = "${load_dir}${pkg}"
  $java_path = "/usr/java/${java_se}1.8.0_${version_major}"
  $env_filepath = "/etc/profile.d/app.sh"


  if $local_repo == 'true' {
    $source    = "${local_source}/${pkg}"
  }
  else {
    $source    = "${cookie} ${oracle_url}8u${version_major}-${version_minor}/${hash}/$pkg"
  }

  # get JDK8 .pkg
  exec { 'upload_pkg':
    command => "sudo wget ${source}",
    path    => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
    cwd     => "${load_dir}",
    creates => "${pkg_path}",
  }

  # install java
  exec { 'install':
    command => "sudo rpm -Uhv ${pkg}",
    path    => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
    cwd     => "${load_dir}",
    creates => "$java_path",
    onlyif  => "test -e ${pkg_path}",
  }

  # set PATH veriables
  $app_sh_hash = {
    'java_path' => $java_path, 'java_se' => $java_se,
  }
  file { "${load_dir}app.sh":
    ensure  => present,
    mode    => '0775',
    content => epp('java8/app.sh.epp', $app_sh_hash),
    before  => Exec['set_path'],
  }
  exec { 'set_path':
    command => "sudo mv /tmp/app.sh /etc/profile.d/",
    path    => '/bin:/sbin',
    onlyif  => "test -e /tmp/app.sh",
    before  => Exec['set_env'],
  }
  exec { 'set_env':
    command      => "${env_filepath}",
    #path        => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    #creates     => '/file/created',
    #cwd         => '/path/to/run/from',
    #user        => 'user_to_run_as',
    #unless      => 'test param-that-would-be-true',
    #refreshonly => true,
  }
}
#http://download.oracle.com/otn-pub/java/jdk/8u162-b12/0da788060d494f5095bf8624735fa2f1/jdk-8u162-linux-x64.rpm
#http://download.oracle.com/otn-pub/java/jdk/8u161-b12/2f38c3b165be4555a1fa6e98c45e0808/jdk-8u161-linux-x64.rpm
#http://download.oracle.com/otn-pub/java/jdk/8u171-b11/512cd62ec5174c3487ac17c61aaa89e8/jdk-8u171-linux-x64.rpm
