#!/bin/bash
# scan the ip address

if [ $# = 1 ];then
    nmap -O $1
else
cat <<EOF
    Usage:
    $0 ip
    nmap -O ip
EOF

fi
