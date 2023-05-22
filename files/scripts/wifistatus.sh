#!/bin/bash

IFACE="wlan0"
ip=$(/usr/sbin/ip -4 addr | grep $IFACE | grep -Po "inet \K[\d.]+")

if [ "$ip" != "" ]; then
	echo " 直 $ip "
else
	echo " 睊  "
fi