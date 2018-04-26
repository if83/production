#!/bin/bash
echo "Configure haproxy.log"

# Configure rsyslog.conf

cat>>/etc/rsyslog.conf<<EOF 

## Configure haproxy
# Provides UDP syslog reception
\$ModLoad imudp
\$UDPServerRun 514

# Provides TCP syslog reception
\$ModLoad imtcp
\$InputTCPServerRun 514

#### RULES ####
local2.*                                                /var/log/haproxy.log

EOF

systemctl restart rsyslog
# <----- WorkSpace configurated ------>