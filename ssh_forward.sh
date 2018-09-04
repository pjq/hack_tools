#!/bin/bash
# Usage: ./ssh_forward.sh localport remoteport
# Forward the local access to the remote server, so you can connect to the remote server to access the local server

#Please update to your user/server
USER="pjq"
REMOTE_SERVER="ef.pjq.me"

if [ $# = 2 ];then
    LOCALPORT=$1
    REMOTEPORT=$2
    #echo ssh -gNfR ${REMOTE_SERVER}:${REMOTEPORT}:localhost:${LOCALPORT} ${USER}@${REMOTE_SERVER}
    #ssh -gNfR ${REMOTE_SERVER}:${REMOTEPORT}:localhost:${LOCALPORT} ${USER}@ef.pjq.me
    echo autossh -f -M 2"$1"  -NR ${REMOTE_SERVER}:${REMOTEPORT}:localhost:${LOCALPORT} ${USER}@${REMOTE_SERVER}
    autossh -f -M 2"$1" -NR  ${REMOTE_SERVER}:${REMOTEPORT}:localhost:${LOCALPORT} "${USER}@${REMOTE_SERVER}"
    echo DONE, Now you can visit it via
    echo http://${REMOTE_SERVER}:${REMOTEPORT}
else
cat <<EOF
    Usage: 
    ./$0 localport remoteport
    For example, forward the localhost port 80 to the remote server 8080
    ssh -gNfR ${REMOTE_SERVER}:8080:localhost:80 pjq@${REMOTE_SERVER}
    Then, you can visit it via: http://${REMOTE_SERVER}:8080
EOF

fi


