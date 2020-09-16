#!/bin/bash

IFACE="wlan0"
ip=$(/usr/sbin/ifconfig $IFACE 2>/dev/null | grep "inet " | awk '{print $2}')

if [ "$ip" != "" ]; then
	echo "直 $ip"
else
	echo "睊 "
fi