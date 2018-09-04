#!/bin/bash
# The script is used to monitor the IP address activities, and find out which process start it.

LOG_DIR="/var/log/monitor_network"
mkdir -p ${LOG_DIR}
DATE=`date +%Y-%m-%d`
LOG="${LOG_DIR}/${DATE}.log"
NETSTAT="${LOG_DIR}/netstat.log"
FILTER_LOG="${LOG_DIR}/filter.log"
FILTER="193.169.252.233|43.240"
FILTER="193.169.252.233|193.169"
SLEEP=10

function dump_info {
     FILTER_RESULT="$1"
     if [ ! -z "${FILTER_RESULT}" ]; then
         echo "Find ${FILTER} in ${FILTER_RESULT}" >>${LOG}
         echo "Find ${FILTER}, dump ps aux >>${LOG}"
         ps aux >>${LOG}
         PID=`echo ${FILTER_RESULT}|grep -E "${FILTER}"|awk '{print $7}'|cut -d "/" -f1`
         #echo "PID:${PID}"
         # Find the PID
         if [ ! -z ${PID} ]; then
             echo "Find ${FILTER} used in PID:${PID}" >>${LOG}
             echo "Dump the /proc/${PID} info: `cat /proc/${PID}/cmdline` "
             cat /proc/${PID}/cmdline >>${LOG}
             echo "" >>${LOG}
             ls -l /proc/${PID}/exe >>${LOG}
             ls -l /proc/${PID}/cwd >>${LOG}
         fi
     else
         echo "Not find ${FILTER}"
     fi
}

function check_network_status {
     echo "netstat -aultnp"
     netstat -aultnp >${NETSTAT}
     cat ${NETSTAT} >>${LOG}
     cat ${NETSTAT}|grep -E "${FILTER}" > ${FILTER_LOG}
     while read line; do
         echo "dump info: ${line}"
         dump_info "${line}"
     done <${FILTER_LOG}
     rm ${NETSTAT} ${FILTER_LOG}
} 

i=0
echo "************************"
echo "Start to monitor network activities for ${FILTER}..."
echo "More details: tail -f ${LOG}"
echo "************************"
while [ $i -le 1000000 ]
do 
    echo "`date` check network status: ${i}, sleep ${SLEEP} seconds" 
    echo "`date` check network status: ${i}" >>${LOG}
    check_network_status 
    sleep ${SLEEP}
    ((i++))
done
