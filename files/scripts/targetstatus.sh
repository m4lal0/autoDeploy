#!/bin/bash

IP=$(cat $HOME/.config/scripts/.targets)

if [[ $IP ]]; then
	echo "<txt><span foreground=\"red\"> 什 $IP </span></txt>"
	echo "<txtclick>bash -c 'printf ${IP} | xclip -selection clipboard | notify-send \"IP ${IP} copiada\"'</txtclick>"
	echo "<tool>TARGET IP</tool>"
else
	echo "<txt> 什  </txt>"
	echo "<tool>TARGET IP</tool>"
fi