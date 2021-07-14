#!/bin/bash

IFACE=$(/usr/sbin/ifconfig | grep -E "tun0|tap0" | awk '{print $1}' | tr -d ':')

if [[ $IFACE == "tun0" ]]; then
	echo "  $(/usr/sbin/ifconfig tun0 | grep "inet " | awk '{print $2}') "
elif [[ $IFACE == "tap0" ]]; then
	echo " 旅 $(/usr/sbin/ifconfig tap0 | grep "inet " | awk '{print $2}') "
else
	echo "   "
fi