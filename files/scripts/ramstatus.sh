#!/usr/bin/env bash

USED_MEM=$(free --giga | awk '/^Mem:/ {printf "%d", $3}')
FREE_MEM=$(free -h --giga | awk '/^Mem:/ {print $3 "/" $2}')

if [ ${USED_MEM} -gt 5 ]; then
        echo "<txt>  <span foreground=\"red\">$FREE_MEM </span></txt>"
        echo "<tool>RAM info</tool>"
elif [ ${USED_MEM} -gt 2 ]; then
        echo "<txt>  <span foreground=\"yellow\">$FREE_MEM </span></txt>"
        echo "<tool>RAM info</tool>"
else
        echo "<txt>  $FREE_MEM </txt>"
        echo "<tool>RAM info</tool>"
fi