#!/bin/bash
# Usage: ./blockip.sh ip
# Block the ip address by iptables

TAG="BlockIPLog"
if [ $# = 1 ];then
    echo "iptables -A INPUT -s ${1} -j DROP"
    iptables -A INPUT -s ${1} -j DROP
    iptables -A INPUT -s ${1} -j LOG --log-prefix "${TAG}"
else
cat <<EOF
    Usage:
    $0 ip 
    Then it will run
    iptables -A INPUT -s ip -j DROP
    iptables -A INPUT -s ip -j LOG --log-prefix "${TAG}"
EOF

fi

