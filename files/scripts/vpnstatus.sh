#!/bin/bash

IFACE="tun0"
ip=$(/usr/sbin/ifconfig $IFACE 2>/dev/null | grep "inet " | awk '{print $2}')

if [ "$ip" != "" ]; then
	if [ "$1" == "--copy" ]; then
		echo -n "$ip" | xclip -sel clip
		notify-send "Copied!"
		exit
	else
		echo " $ip"
	fi
else
	echo " "
fi