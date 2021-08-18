#!/bin/bash

IP=$(cat $HOME/.config/scripts/.targets)

if [[ $IP ]]; then
	echo " 什 $IP "
else
	echo " 什  "
fi