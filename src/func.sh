#!/bin/bash
#by @m4lal0

# Regular Colors
Black='\033[0;30m'      # Black
Red='\033[0;31m'        # Red
Green='\033[0;32m'      # Green
Yellow='\033[0;33m'     # Yellow
Blue='\033[0;34m'       # Blue
Purple='\033[0;35m'     # Purple
Cyan='\033[0;36m'       # Cyan
White='\033[0;97m'      # White
Blink='\033[5m'         # Blink
Color_Off='\033[0m'     # Text Reset

# Additional colors
LGray='\033[0;37m'      # Ligth Gray
DGray='\033[0;90m'      # Dark Gray
LRed='\033[0;91m'       # Ligth Red
LGreen='\033[0;92m'     # Ligth Green
LYellow='\033[0;93m'    # Ligth Yellow
LBlue='\033[0;94m'      # Ligth Blue
LPurple='\033[0;95m'    # Light Purple
LCyan='\033[0;96m'      # Ligth Cyan

# Bold
BBlack='\033[1;30m'     # Black
BGray='\033[1;37m'		# Gray
BRed='\033[1;31m'       # Red
BGreen='\033[1;32m'     # Green
BYellow='\033[1;33m'    # Yellow
BBlue='\033[1;34m'      # Blue
BPurple='\033[1;35m'    # Purple
BCyan='\033[1;36m'      # Cyan
BWhite='\033[1;37m'     # White

# Italics
IBlack='\033[3;30m'     # Black
IGray='\033[3;90m'      # Gray
IRed='\033[3;31m'       # Red
IGreen='\033[3;32m'     # Green
IYellow='\033[3;33m'    # Yellow
IBlue='\033[3;34m'      # Blue
IPurple='\033[3;35m'    # Purple
ICyan='\033[3;36m'      # Cyan
IWhite='\033[3;37m'     # White

# Underline
UBlack='\033[4;30m'     # Black
UGray='\033[4;37m'		# Gray
URed='\033[4;31m'       # Red
UGreen='\033[4;32m'     # Green
UYellow='\033[4;33m'    # Yellow
UBlue='\033[4;34m'      # Blue
UPurple='\033[4;35m'    # Purple
UCyan='\033[4;36m'      # Cyan
UWhite='\033[4;37m'     # White

# Background
On_Black='\033[40m'     # Black
On_Red='\033[41m'       # Red
On_Green='\033[42m'     # Green
On_Yellow='\033[43m'    # Yellow
On_Blue='\033[44m'      # Blue
On_Purple='\033[45m'    # Purple
On_Cyan='\033[46m'      # Cyan
On_White='\033[47m'     # White

trap ctrl_c INT

function ctrl_c(){
    echo -e "\n\n${Cyan}[${BYellow}!${Cyan}] ${BRed}Saliendo de la aplicación...${Color_Off}"
    tput cnorm
    exit 1
}

### Panel de Ayuda
function helpPanel(){
    echo -e "\n${Cyan}[${BYellow}!${Cyan}]${BGray} Uso:${Color_Off}"
    echo -e "\n\t${LGreen}./autoDeploy.sh ${LRed}[OPCION]${Color_Off}"
    echo -e "\n${BGray}OPCIONES:${Color_Off}"
    echo -e "\t${Cyan}[${Red}-i, --install${Cyan}]${Purple} \tInstalación completa de la capa de personalización.${Color_Off}"
    echo -e "\t\t${Yellow}terminal: ${Purple}\tInstalación solamente de la personalización de la terminal y escritorio.${Color_Off}"
    echo -e "\t\t${Yellow}apps: ${Purple}\t\tInstalación solamente de los programas de terceros.${Color_Off}"
    echo -e "\t${Cyan}[${Red}-d, --delete${Cyan}]${Purple} \t\tEliminar configuración de Escritorio y directorios de los aplicativos de terceros.${Color_Off}"
    echo -e "\t${Cyan}[${Red}-h, --help${Cyan}]${Purple} \t\tMostrar este panel de ayuda.${Color_Off}"
    echo -e "\n${BGray}EJEMPLOS:${Color_Off}"
    echo -e "\t${LGray}Instalación Completa (root)${Color_Off}${Green}\n\t# ./autoDeploy.sh ${Red}--install\n${Color_Off}"
    echo -e "\t${LGray}Instalación solamente con personalización de terminal y escritorio (root)${Color_Off}${Green}\n\t# ./autoDeploy.sh ${Red}--install ${Yellow}terminal\n${Color_Off}"
    echo -e "\t${LGray}Instalación solamente con aplicativos de terceros (root)${Color_Off}${Green}\n\t# ./autoDeploy.sh ${Red}--install ${Yellow}apps\n${Color_Off}"
    echo -e "\t${LGray}Eliminar configuración de escritorio y directorios de aplicativos${Color_Off}${Green}\n\t# ./autoDeploy.sh ${Red}-d\n${Color_Off}"
    tput cnorm; exit 1
}

### Banner
function banner(){
    echo -e "${BYellow}"
    sleep 0.15 && echo -e "\t                     __              _______                    __                   "
    sleep 0.15 && echo -e "\t                    |  \            |       \                  |  \                  "
    sleep 0.15 && echo -e "\t  ______  __    __ _| ▓▓_    ______ | ▓▓▓▓▓▓▓\ ______   ______ | ▓▓ ______  __    __ "
    sleep 0.15 && echo -e "\t |      \|  \  |  \   ▓▓ \  /      \| ▓▓  | ▓▓/      \ /      \| ▓▓/      \|  \  |  \\"
    sleep 0.15 && echo -e "\t  \▓▓▓▓▓▓\ ▓▓  | ▓▓\▓▓▓▓▓▓ |  ▓▓▓▓▓▓\ ▓▓  | ▓▓  ▓▓▓▓▓▓\  ▓▓▓▓▓▓\ ▓▓  ▓▓▓▓▓▓\ ▓▓  | ▓▓"
    sleep 0.15 && echo -e "\t /      ▓▓ ▓▓  | ▓▓ | ▓▓ __| ▓▓  | ▓▓ ▓▓  | ▓▓ ▓▓    ▓▓ ▓▓  | ▓▓ ▓▓ ▓▓  | ▓▓ ▓▓  | ▓▓"
    sleep 0.15 && echo -e "\t|  ▓▓▓▓▓▓▓ ▓▓__/ ▓▓ | ▓▓|  \ ▓▓__/ ▓▓ ▓▓__/ ▓▓ ▓▓▓▓▓▓▓▓ ▓▓__/ ▓▓ ▓▓ ▓▓__/ ▓▓ ▓▓__/ ▓▓"
    sleep 0.15 && echo -e "\t \▓▓    ▓▓\▓▓    ▓▓  \▓▓  ▓▓\▓▓    ▓▓ ▓▓    ▓▓\▓▓     \ ▓▓    ▓▓ ▓▓\▓▓    ▓▓\▓▓    ▓▓"
    sleep 0.15 && echo -e "\t  \▓▓▓▓▓▓▓ \▓▓▓▓▓▓    \▓▓▓▓  \▓▓▓▓▓▓ \▓▓▓▓▓▓▓  \▓▓▓▓▓▓▓ ▓▓▓▓▓▓▓ \▓▓ \▓▓▓▓▓▓ _\▓▓▓▓▓▓▓"
    sleep 0.15 && echo -e "\t                                                      | ▓▓                 |  \__| ▓▓"
    sleep 0.15 && echo -e "\t                                                      | ▓▓                  \▓▓    ▓▓"
    sleep 0.15 && echo -e "\t                                                       \▓▓                   \▓▓▓▓▓▓ "
    echo -e "${Color_Off}"
	sleep 0.15 && echo -e "\t${On_Blue}${BWhite} Script para personalizar el entorno de trabajo de Kali Linux .:.:. By ${On_Blue}${BYellow}@m4lal0${On_Blue}${BWhite} .:.:. ${Color_Off}\n"
	tput civis
}

### Funciones informativos
function info(){
	echo -e "${Cyan}[${BYellow}!${Cyan}] ${BGray}$1${Color_Off}"
}

function question(){
	input=""
	while [ "$input" == "" ]; do
		echo -ne "${Cyan}[${BPurple}?${Cyan}] ${BGray}$1: ${Color_Off}" && read input
	done
}

function yes_or_no(){
	echo -ne "${Cyan}[${BPurple}?${Cyan}] ${BGray}$1 ${Cyan}(${BGreen}Y${BGray}/${BRed}n${Cyan})${BGray}: ${Color_Off}" && read input
	case "$input" in
		n|N) input=0;;
		*) input=1;;
	esac
}

function error(){
	echo -e "${Cyan}[${BRed}✘${Cyan}] ${BRed}Error - $1${Color_Off}"
	echo -e "[$(date +%T)] $1" 2>/dev/null >> $SCRIPT_PATH/error.log
}

function good(){
	echo -e "${Cyan}[${BGreen}✔${Cyan}] ${BGreen}Exitoso - $1${Color_Off}"
}

function check(){
	if [ $? -ne 0 ]; then 
		error "$1"
	else
		good "$1"
	fi
}

function section(){
	echo -e "\n${Cyan}[${BBlue}+${Cyan}] ${BBlue}$1${Color_Off}"
}

### Eliminando directorios de los aplicativos descargados de Github
function deleteApp(){
	validations
	info "Eliminando directorios de aplicativos."
	if [[ -d $EVASION_PATH || -d $PRIVESCLIN_PATH || -d $PRIVESCWIN_PATH || -d $OSINT_PATH || -d $UTILITIES_PATH || -d $WEB_PATH || -d $WIFI_PATH ]]; then
		rm -rf {$EVASION_PATH,$PRIVESCLIN_PATH,$PRIVESCWIN_PATH,$OSINT_PATH,$UTILITIES_PATH,$WEB_PATH,$WIFI_PATH} 2>&1
		check "Eliminado directorios."
	else
		error "No hay directorios de aplicativos instalados."
	fi
	info "Eliminando configuracion de Escritorio."
	rm -rf $HOME_PATH/.config/xfce4 2>/dev/null
	check "Eliminando configuración escritorio."
	sleep 2
	tput cnorm && reboot
}

### Revisando conexión a Internet
function checkInternet(){
	info "Comprobando resolución DNS"
	host www.google.com > /dev/null 2>&1
	if [ $? -ne 0 ]; then
		error "En la resolución DNS - no se pudo resolver www.google.com"
		exit 1
	fi
}

function validations(){
### Validación de ejecución con root
	if [[ ! -d tools || ! -d files ]]; then
		echo -e "\n${Cyan}[${BYellow}!${Cyan}] ${BRed}Ejecuta este script desde la carpeta de autoDeploy para evitar errores${Color_Off}\n"
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

### Main instalation
function install(){
	echo -e "\n${Cyan}[${BYellow}*${Cyan}] ${BYellow}Instalación Completa.${Color_Off}\n"
	validations
	installPackages
	installApps
	customTerminal
	gitTools
	endInstall
}

function installTerminal(){
	echo -e "\n${Cyan}[${BYellow}*${Cyan}] ${BYellow}Instalación de la capa de personalización de la Terminal y Escritorio.${Color_Off}\n"
	validations
	installPackages
	customTerminal
	endInstall
}

function installTerceros(){
	echo -e "\n${Cyan}[${BYellow}*${Cyan}] ${BYellow}Instalación de Aplicativos de terceros.${Color_Off}\n"
	validations
	installPackages
	installApps
	gitTools
	endInstall
}

### Finalización del script
function endInstall(){
	info "Actualizacion de updatedb"
	sudo updatedb > /dev/null 2>&1
	check "Ejecutando updatedb"
	section "INSTALACIÓN FINALIZADA"
	tput cnorm
	info "Debes reiniciar el ordenador para terminar la instalación"
	yes_or_no "¿Quieres hacerlo ahora?"

	section "Happy Hacking! =)" && sleep 2
	if [ $input -eq 1 ]; then
		reboot
	fi
}