#!/bin/bash
#Usage ./lastlogin.sh username or it will print all the login info
for wtmp in `find /var/log/ -iname "wtmp*"|sort`
do
    last -f ${wtmp} $1
    #last -f /var/log/wtmp $1
done

