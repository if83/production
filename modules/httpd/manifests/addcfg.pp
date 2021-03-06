# == Define: httpd::addcfg
# ===========================
#
# Use it to add some.conf file to /httpd/conf.d/
#
# @ param
#    enter the number of port you wish to open
#
# @example
# 1. create a variable with conf written in a sach way
#  $variable = @(CONF)
#    Change this block of text
#    with your config
#    | CONF
#
# 2. include this defined type
#
#    httpd::addcfg { 'some title'
#      conf_name => "some.conf", # name of config file
#      conf_text => $variable,   # config as a heredocs
#    }

define httpd::addcfg (
  $conf_name,
  $conf_text,
  $user  = 'root',
  $group = 'wheel',
  ) {
  require httpd

  file { "/etc/httpd/conf.d/${conf_name}":
    ensure  => file,
    mode    => '0744',
    owner   => $user,
    group   => $group,
    content => $conf_text,
  }
}
