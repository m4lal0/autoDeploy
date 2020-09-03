#!/bin/bash
#by @M4lal0

### Colours
greenColour="\e[0;32m\033[1m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"
endColour="\033[0m\e[0m"

### Banner
function banner(){
    echo -e "${yellowColour}"
    sleep 0.15 && echo -e "                     __              _______                    __                   "
    sleep 0.15 && echo -e "                    |  \            |       \                  |  \                  "
    sleep 0.15 && echo -e "  ______  __    __ _| ▓▓_    ______ | ▓▓▓▓▓▓▓\ ______   ______ | ▓▓ ______  __    __ "
    sleep 0.15 && echo -e " |      \|  \  |  \   ▓▓ \  /      \| ▓▓  | ▓▓/      \ /      \| ▓▓/      \|  \  |  \\"
    sleep 0.15 && echo -e "  \▓▓▓▓▓▓\ ▓▓  | ▓▓\▓▓▓▓▓▓ |  ▓▓▓▓▓▓\ ▓▓  | ▓▓  ▓▓▓▓▓▓\  ▓▓▓▓▓▓\ ▓▓  ▓▓▓▓▓▓\ ▓▓  | ▓▓"
    sleep 0.15 && echo -e " /      ▓▓ ▓▓  | ▓▓ | ▓▓ __| ▓▓  | ▓▓ ▓▓  | ▓▓ ▓▓    ▓▓ ▓▓  | ▓▓ ▓▓ ▓▓  | ▓▓ ▓▓  | ▓▓"
    sleep 0.15 && echo -e "|  ▓▓▓▓▓▓▓ ▓▓__/ ▓▓ | ▓▓|  \ ▓▓__/ ▓▓ ▓▓__/ ▓▓ ▓▓▓▓▓▓▓▓ ▓▓__/ ▓▓ ▓▓ ▓▓__/ ▓▓ ▓▓__/ ▓▓"
    sleep 0.15 && echo -e " \▓▓    ▓▓\▓▓    ▓▓  \▓▓  ▓▓\▓▓    ▓▓ ▓▓    ▓▓\▓▓     \ ▓▓    ▓▓ ▓▓\▓▓    ▓▓\▓▓    ▓▓"
    sleep 0.15 && echo -e "  \▓▓▓▓▓▓▓ \▓▓▓▓▓▓    \▓▓▓▓  \▓▓▓▓▓▓ \▓▓▓▓▓▓▓  \▓▓▓▓▓▓▓ ▓▓▓▓▓▓▓ \▓▓ \▓▓▓▓▓▓ _\▓▓▓▓▓▓▓"
    sleep 0.15 && echo -e "                                                      | ▓▓                 |  \__| ▓▓"
    sleep 0.15 && echo -e "                                                      | ▓▓                  \▓▓    ▓▓"
    sleep 0.15 && echo -e "                                                       \▓▓                   \▓▓▓▓▓▓ "
    echo -e "${endColour}"
	sleep 0.15 && echo -e "\t\t    ${greenColour}---[ Github: https://github.com/m4lal0/autoDeploy.git ]--- ${endColour}"
    sleep 0.15 && echo -e "\t\t\t\t\t\t    ${greenColour} +--==[ By @M4lal0 ]==-- +${endColour}\n\n"
	tput civis
}

### Funciones informativos
function info(){
	echo -e "${turquoiseColour}[${yellowColour}!${turquoiseColour}] ${grayColour}$1${endColour}"
}

function question(){
	input=""
	while [ "$input" == "" ]; do
		echo -ne "${turquoiseColour}[${purpleColour}?${turquoiseColour}] ${grayColour}$1: ${endColour}" && read input
	done
}

function yes_or_no(){
	echo -ne "${turquoiseColour}[${purpleColour}?${turquoiseColour}] ${grayColour}$1 ${turquoiseColour}(${greenColour}Y${grayColour}/${redColour}n${turquoiseColour})${grayColour}: ${endColour}" && read input
	case "$input" in
		n|N) input=0;;
		*) input=1;;
	esac
}

function error(){
	echo -e "${redColour}[X] Error - $1${endColour}"
	echo -e "[$(date +%T)] $1" 2>/dev/null >> $SCRIPT_PATH/error.log
}

function good(){
	echo -e "${greenColour}[V] Correct - $1${endColour}"
}

function check(){
	if [ $? -ne 0 ]; then 
		error "$1"
	else
		good "$1"
	fi
}

function section(){
	echo -e "\n${turquoiseColour}[${blueColour}+${turquoiseColour}] ${blueColour}$1${endColour}"
}

### Revisando conexión a Internet
function checkInternet(){
	info "Comprobando resolución DNS"
	host www.google.com > /dev/null 2>&1
	if [ $? -ne 0 ]; then
		error "Fallo en la resolución DNS - no se pudo resolver www.google.com"
		exit 1
	fi
}

function validations(){
### Validación de ejecución con root
	if [ ! -d "files/" ]; then
		echo -e "\n[!] Ejecuta este script desde la carpeta de AutoDeploy para evitar errores\n"
		exit 1
	fi
	rm -f $SCRIPT_PATH/error.log 2>/dev/null
	if [ "$EUID" -ne 0 ]; then
		error "Este script debe ser ejecutado por r00t!\n"
		exit 1
	fi

### Datos del equipo
    question "Hostname"
	HOSTNAME=$input
	question "Nombre de usuario ($(ls /home | xargs | tr ' ' ','))"
	USERNAME=$input
	HOME_PATH="/home/$USERNAME"

	if [ ! -d "$HOME_PATH" ]; then
		error "El directorio home del usuario no existe (/home/$USERNAME)"
		exit 1
	fi
}

### Finalización del script
function endInstall(){
	section "INSTALACIÓN FINALIZADA"
	tput cnorm
	info "Debes reiniciar el ordenador para terminar la instalación"
	yes_or_no "¿Quieres hacerlo ahora?"

	section "Happy Hacking! =)" && sleep 2
	if [ $input -eq 1 ]; then
		reboot
	fi
}