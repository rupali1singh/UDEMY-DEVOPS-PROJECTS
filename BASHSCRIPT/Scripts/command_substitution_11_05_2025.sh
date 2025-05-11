#!/bin/bash

echo "Welcome $USER on $HOSTNAME"
echo "########################################"

FREERAM=$(free -m|grep Mem |awk '{print $4}')
LOAD=`uptime |awk '{print $9}'`
ROOTFREE= $(df -h|greo '/dev/sdal' |awk '{print $4}')


echo "#######################################"
echo "AVAILABLE FREE RAM IS $FREERAM MB"
echo "#######################################"
echo "CURRENT LOAD AVERAGE $LOAD"
echo "#######################################"
echo "FREE ROOT PARTITION SIZE IS $ROOTFREE"
