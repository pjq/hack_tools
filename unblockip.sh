#!/bin/bash
# Usage: ./unblockip.sh ip
# Block the ip address by iptables

TAG="BlockIPLog"
if [ $# = 1 ];then
    echo "iptables -D INPUT -s ${1} -j DROP"
    iptables -D INPUT -s ${1} -j DROP
    iptables -D INPUT -s ${1} -j LOG --log-prefix "${TAG}"
else
cat <<EOF
    Usage:
    $0 ip 
    Then it will run
    iptables -D INPUT -s ip -j DROP
    iptables -D INPUT -s ip -j LOG --log-prefix "${TAG}"
EOF

fi

