#!/bin/bash
#by @M4lal0

### Panel de Ayuda
function helpPanel(){
    echo -e "\n${turquoiseColour}[${yellowColour}!${turquoiseColour}]${yellowColour} Uso:${endColour}"
    echo -e "\nScript que permite instalar una capa de personalización en Kali Linux OS."
    echo -e "\n${grayColour}OPCIONES:${endColour}"
    echo -e "\t${turquoiseColour}[${redColour}-h, --help${turquoiseColour}]${purpleColour} \tMostrar este panel de ayuda${endColour}"
    echo -e "\t${turquoiseColour}[${redColour}-d, --delete${turquoiseColour}]${purpleColour} \tEliminar directorios de los aplicativos creados${endColour}"
    echo -e "\n${grayColour}EJEMPLOS:${endColour}"
    echo -e "\t${grayColour}Instalación (root)${endColour}${greenColour}\n\t# bash autoDeploy.sh\n${endColour}"
    echo -e "\t${grayColour}Eliminar directorios de aplicativos${endColour}${greenColour}\n\t# bash autoDeploy.sh -d\n${endColour}"
    tput cnorm; exit 1
}