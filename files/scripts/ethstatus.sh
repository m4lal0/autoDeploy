#!/bin/bash

IFACE="eth0"
ip=$(/usr/sbin/ifconfig $IFACE 2>/dev/null | grep "inet " | awk '{print $2}')

if [ "$ip" != "" ]; then
	echo "  $ip "
else
	echo "   "
fi