#!/usr/bin/env bash

IFACE=$(/usr/sbin/ip -4 addr | grep -E "tun0|tap0" | grep -Po "inet \K[\d.]+")

if [[ $IFACE ]]; then
	echo " 旅 $IFACE "
else
	echo "   "
fi