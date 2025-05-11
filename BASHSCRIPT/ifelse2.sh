#!/bin/bash

VALUE=$(ip addr show | grep -v LOOPBACK |grep -ic mtu)

if [ $VALUE -eq 1 ]
then
        echo "1 Active Network Interface"
elif [ $VALUE -gt 1 ]
then
        echo "Multiple Network Interface"
else
        echo "No Active Network Interface"
fi
