#!/bin/bash
#by @m4lal0

### Panel de Ayuda
function helpPanel(){
    echo -e "\n${Cyan}[${BYellow}!${Cyan}]${BGray} Uso:${Color_Off}"
    echo -e "\nScript que permite instalar una capa de personalización en Kali Linux OS."
    echo -e "\n${BGray}OPCIONES:${Color_Off}"
    echo -e "\t${Cyan}[${Red}-h, --help${Cyan}]${Purple} \tMostrar este panel de ayuda${Color_Off}"
    echo -e "\t${Cyan}[${Red}-d, --delete${Cyan}]${Purple} \tEliminar directorios de los aplicativos creados${Color_Off}"
    echo -e "\n${BGray}EJEMPLOS:${Color_Off}"
    echo -e "\t${LGray}Instalación (root)${Color_Off}${Green}\n\t# bash autoDeploy.sh\n${Color_Off}"
    echo -e "\t${LGray}Eliminar directorios de aplicativos${Color_Off}${Green}\n\t# bash autoDeploy.sh -d\n${Color_Off}"
    tput cnorm; exit 1
}