#!/usr/bin/env bash

IFACE="wlan0"
IP="$(ip a s "${IFACE}" 2>/dev/null | grep -o -P '(?<=inet )[0-9]{1,3}(\.[0-9]{1,3}){3}')"

if [ "${IP}" != "" ]; then
	echo "<txt><span foreground=\"cyan\"> 󰖩 $ip </span></txt>"
	echo "<txtclick>bash -c 'printf ${IP} | xclip -selection clipboard | notify-send \"IP ${IP} copiada\"'</txtclick>"
	echo "<tool>WiFi IP</tool>"
else
	echo "<txt> 󰖪  </txt>"
	echo "<tool>WiFi IP</tool>"
fi