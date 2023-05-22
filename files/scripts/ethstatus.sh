#!/bin/bash

IFACE="eth0"
ip=$(/usr/sbin/ip -4 addr | grep $IFACE | grep -Po "inet \K[\d.]+")

if [ "$ip" != "" ]; then
	echo "  $ip "
else
	echo "   "
fi