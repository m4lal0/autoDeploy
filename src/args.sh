#!/bin/bash
#by @M4lal0

### Panel de Ayuda
function helpPanel(){
    echo -e "\n${yellowColour}[!]${endColour}${grayColour} Uso:${endColour}"
    echo -e "\nScript que permite instalar una capa de personalización en Kali Linux OS."
    echo -e "\n${grayColour}OPCIONES:${endColour}"
    echo -e "\t${blueColour}[-h]${endColour}${turquoiseColour} Mostrar este panel de ayuda${endColour}"
    echo -e "\n${grayColour}EJEMPLO:${endColour}"
    echo -e "\t${grayColour}Instalación (root)${endColour}${turquoiseColour}\n\t# bash autoDeploy.sh\n${endColour}"
    exit 1
}