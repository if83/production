# Class: rsyslog
# ===========================
#
# configuration parameters which allowed clients connect to rsyslog server
# are placed in rsyslog::client defined type
# Here are the main ones with their default values: 
#  $log_proto = 'tcp',
#  $log_port  = '601',
#  $log_serv  = '192.168.56.10',
# Copyright
# ---------
#
# Copyright 2018 oleksdiam
#
class rsyslog (

  $log_proto = 'tcp',
  $log_port  = '514',
  $log_serv  = '192.168.56.10',
){

}
