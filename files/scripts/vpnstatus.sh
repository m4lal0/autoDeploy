#!/usr/bin/env bash

IFACE=$(/usr/sbin/ifconfig | grep -E "tun0|tap0" | awk '{print $1}' | tr -d ':')

if [[ $IFACE ]]; then
	echo " 旅 $(/usr/sbin/ifconfig $IFACE | grep "inet " | awk '{print $2}') "
else
	echo "   "
fi