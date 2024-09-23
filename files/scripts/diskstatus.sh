#!/usr/bin/env bash

DISK_PR=$(df -h | awk '$NF=="/"{printf "%s, $5}')
DISK=$(df -h | awk '$NF=="/"{printf "%.1fGB/%.1fGB", $3, $2}')

if [ ${DISK_PR} -gt 90 ]; then
        echo "<txt>  <span foreground=\"red\">$DISK </span></txt>"
                echo "<tool>DISK info</tool>"
elif [ ${DISK_PR} -gt 70 ]; then
        echo "<txt>  <span foreground=\"yellow\">$DISK </span></txt>"
                echo "<tool>DISK info</tool>"
else
        echo "<txt>  $DISK </txt>"
                echo "<tool>DISK info</tool>"
fi