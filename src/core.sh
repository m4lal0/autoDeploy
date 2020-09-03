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
GIT_TOOLS_LIST="$TOOLS_PATH/github.txt"
PIP_TOOLS_LIST="$TOOLS_PATH/pip.txt"
PACKAGES_LIST=$(cat $TOOLS_PATH/packages.txt | tr '\r\n' ' ')

### Llamado del Banner
banner

### Opciones
while getopts "h" arg; do
	case $arg in
		h)  helpPanel;;
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