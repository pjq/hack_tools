#!/bin/bash

# for mac
#IP=`ifconfig|grep -A 4  -E "en.:|eth0"|grep "inet "|grep -v "127.0"|awk -F "netmask" '{print $1}'|cut -d " " -f2|sed 's/ //g'|head -n 1`
# for linux
IP=`ifconfig|grep -A 4  -E "en.:|eth0"|grep "inet "|grep -v "127.0"|awk -F "netmask|Mask" '{print $1}'|sed 's/Bcast.*//g'|sed 's/inet.*://g'|sed 's/inet//g'|sed 's/ //g'`
echo "local IP:${IP}"
#REMOTE_IP=`curl -s ifconfig.me`
REMOTE_IP=`curl -s https://www.ip.cn/`
echo "Remote IP:${REMOTE_IP}"
