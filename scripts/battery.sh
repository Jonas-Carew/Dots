#!/bin/sh

BAT_PATH=`upower -e | grep 'battery'`
INFO=`upower -i ${BAT_PATH}`

CHARGE=`upower -i ${BAT_PATH} | grep 'percentage:' | tr -s ' ' | cut -d' ' -f3`
TIME=`upower -i ${BAT_PATH} | grep 'time to empty:' | tr -s ' ' | cut -d' ' -f5-6`
STATE=`upower -i ${BAT_PATH} | grep 'state:' | tr -s ' ' | cut -d' ' -f3`
HEALTH=`upower -i ${BAT_PATH} | grep 'capacity:' | tr -s ' ' | cut -d' ' -f3`
echo "Current charge: ${CHARGE}"
echo "Time to Drain:  ${TIME}"
echo "Current State:  ${STATE}"
echo "Battery Health: ${HEALTH}"
