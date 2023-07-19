#!/bin/bash
#by @m4lal0

source src/func.sh
source src/utils.sh
source src/custom.sh

### Variables globales
SCRIPT_PATH="$(pwd)"
FILES_PATH="$SCRIPT_PATH/files"
TOOLS_PATH="$SCRIPT_PATH/tools"
GIT_TOOLS_PATH="/opt"

PRIVESCLIN_PATH="$GIT_TOOLS_PATH/PrivEsc-Lin"
PRIVESCWIN_PATH="$GIT_TOOLS_PATH/PrivEsc-Win"
OSINT_PATH="$GIT_TOOLS_PATH/OSINT"
UTILITIES_PATH="$GIT_TOOLS_PATH/Utilities"
WEB_PATH="$GIT_TOOLS_PATH/Web"
WIFI_PATH="$GIT_TOOLS_PATH/Wifi"
WORDPRESS_PATH="$WEB_PATH/Wordpress"
AD_PATH="$GIT_TOOLS_PATH/AD"

GIT_TOOLS_LIST="$TOOLS_PATH/github.txt"
PIP_TOOLS_LIST="$TOOLS_PATH/pip.txt"
GO_TOOLS_LIST="$TOOLS_PATH/gotools.txt"
PACKAGES_LIST=$(cat $TOOLS_PATH/packages.txt | tr '\r\n' ' ')

clear
banner

### Opciones
arg=""
for arg; do
	delim=""
	case $arg in
		--install)	args="${args}-i";;
		--help)		args="${args}-h";;
		--delete)	args="${args}-d";;
		*) [[ "${arg:0:1}" == "-" ]] || delim="\""
        args="${args}${delim}${arg}${delim} ";;
	esac
done

eval set -- $args

declare -i parameter_counter=0; while getopts ":i:dh" opt; do
	case $opt in
		i) install=$OPTARG && let parameter_counter+=1 ;;
		h) helpPanel ;;
		d) deleteApp ;;
		:) install ;;
		*) helpPanel ;;
	esac
done

if [ $parameter_counter -eq 0 ]; then
	helpPanel
else
	if [ "$(echo $install)" == "terminal" ]; then
		installTerminal
	elif [ "$(echo $install)" == "apps" ]; then
		installTerceros
	else
		helpPanel
	fi
fi