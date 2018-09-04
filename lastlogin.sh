#!/bin/bash

last -f /var/log/wtmp $1
last -f /var/log/wtmp.1 $1
