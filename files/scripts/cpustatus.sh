#!/usr/bin/env bash

CPU=$(top -bn 2 -d 0.2 | grep '^%Cpu' | tail -n 1 | awk '{printf "%02d", $2+$4+$6}')

if [ ${CPU} -gt 90 ]; then
        echo "<txt> 󰻠 <span foreground=\"red\">$CPU </span></txt>"
		echo "<tool>CPU info</tool>"
elif [ ${CPU} -gt 70 ]; then
        echo "<txt> 󰻠 <span foreground=\"yellow\">$CPU </span></txt>"
		echo "<tool>CPU info</tool>"
else
        echo "<txt> 󰻠 $CPU </txt>"
		echo "<tool>CPU info</tool>"
fi