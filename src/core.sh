#!/bin/bash
#by @M4lal0

source src/func.sh
source src/args.sh
source src/utils.sh
source src/custom.sh

### Variables globales
SCRIPT_PATH="$(pwd)"
FILES_PATH="$SCRIPT_PATH/files"
TOOLS_PATH="$SCRIPT_PATH/tools"
GIT_TOOLS_PATH="/opt"

EVASION_PATH="$GIT_TOOLS_PATH/Evasion"
PRIVESCLIN_PATH="$GIT_TOOLS_PATH/PrivEsc-Lin"
PRIVESCWIN_PATH="$GIT_TOOLS_PATH/PrivEsc-Win"
OSINT_PATH="$GIT_TOOLS_PATH/OSINT"
UTILITIES_PATH="$GIT_TOOLS_PATH/Utilities"
WEB_PATH="$GIT_TOOLS_PATH/Web"
WIFI_PATH="$GIT_TOOLS_PATH/Wifi"
WORDPRESS_PATH="$WEB_PATH/Wordpress"

GIT_TOOLS_LIST="$TOOLS_PATH/github.txt"
PIP_TOOLS_LIST="$TOOLS_PATH/pip.txt"
PACKAGES_LIST=$(cat $TOOLS_PATH/packages.txt | tr '\r\n' ' ')

clear
banner

### Opciones
arg=""
for arg; do
	delim=""
	case $arg in
		--help)		args="${args}-h";;
		--delete)	args="${args}-d";;
		*) [[ "${arg:0:1}" == "-" ]] || delim="\""
        args="${args}${delim}${arg}${delim} ";;
	esac
done

eval set -- $args

while getopts "dh" opt; do
	case $opt in
		h)  helpPanel;;
		d)  deleteApp;;
		*) exit 1;
	esac
done

### Main
function main(){
	validations
	installPackages
	installApps
	customTerminal
	gitTools
	endInstall
}