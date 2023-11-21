#!/bin/bash

# Define the IP addresses to exclude (comma-separated, without spaces)
exclude_ips="100.117.199.33,101.230.72.103"

while true
do
    # Find unwanted ssh connections
    sudo ss -tunp | grep ':22 ' | while read line 
    do
        if echo $line | grep -qE $(echo $exclude_ips | tr "," "|"); then
            continue
        else
            pid=$(echo $line | sed -n -r 's/.*pid=([0-9]+).*/\1/p')

            echo "Unusual SSH connection found from:"
            echo $line

            echo "Here are more details about the process with PID: $pid"

            # Information about the process executing file
            echo "<<Process Executing File>>"
            sudo ls -l /proc/$pid/exe

            # Information about the process files
            echo "<<Process Files>>"
            #sudo lsof -p $pid

            # Detailed information about the process
            echo "<<Process Info>>"
            ps -fp $pid

            # Current working directory of the process
            echo "<<Process Working Directory>>"
            sudo pwdx $pid

            echo "-----------"
        fi
    done

    # Wait for 5 seconds before the next check
    sleep 1
done

