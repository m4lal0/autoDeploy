# autoDeploy

[![GitHub top language](https://img.shields.io/github/languages/top/m4lal0/autoDeploy?logo=gnu-bash&style=flat-square)](#)
[![GitHub repo size](https://img.shields.io/github/repo-size/m4lal0/autoDeploy?logo=webpack&style=flat-square)](#)
[![Kali Linux Supported](https://img.shields.io/badge/Kali_Linux_2020-Supported-blue?style=flat-square&logo=linux)](#)
[![By](https://img.shields.io/badge/By-m4lal0-green?style=flat-square&logo=github)](#)

<p align="center">
<img src="https://github.com/m4lal0/autoDeploy/blob/master/images/autodeploy.png"
	alt="autoDeploy"
	width="1000"
	style="float: left; margin-right: 10px;" />
</p>

AutoDeploy es un script que permite instalar una capa de personalización en Kali Linux OS. Instala diferentes plugins, aplicaciones y utilidades para tener un entorno más agradable para trabajar.

## Instalación y Uso

Ejecutarlo como root:

```bash
git clone https://github.com/m4lal0/autoDeploy
cd autoDeploy; chmod +x autoDeploy.sh
./autoDeploy.sh
```

Al ejecutarlo nos mostrará un panel de ayuda:

<p align="center">
<img src="https://github.com/m4lal0/autoDeploy/blob/master/images/helpPanel.png"
	alt="helpPanel"
	width="1000"
	style="float: left; margin-right: 10px;" />
</p>

El script cuenta con **3** modos de instalación:
##### Instalación completa
```bash
./autoDeploy.sh --install
```
##### Instalar personalización de terminal y escritorio xfce
```bash
./autoDeploy.sh --install terminal
```
##### Instalar aplicaciones de terceros
```bash
./autoDeploy.sh --install apps
```

Al inicio solicitará unos datos para el proceso de instalación, el resto de la ejecución debería de realizarse automáticamente sin necesitar interacción del usuario. Si algún paso del error de instalación falla, se almacena una copia del error en el fichero **error.log** para que estos puedan ser solucionados posteriormente de forma manual.

## Utilidades

<p align="center">
<img src="https://github.com/m4lal0/autoDeploy/blob/master/images/preview.PNG"
	alt="autoDeploy"
	width="1000"
	style="float: left; margin-right: 10px;" />
</p>
Estas son algunas de las aplicaciones y utilidades que se incluyen en esta capa de personalización:

- Configuración de fuente Hacker Nerd
- Instalación de algunas aplicaciones
    + Google Chrome
    + Gotop
    + upDog
    + impacket
    + entre otras...
- zsh + powerlevel10k
    + lsd
    + bat
    + fzf
- Oh my Tmux!
- Algunas funciones creadas para el zshrc
    + Colorido para manuales
    + Borrado de archivo anti-Forense
    + entre otras...
- Instalación de otros paquetes
    + rlwrap
    + xclip
    + steghide
    + fcrackzip
    + rofi
    + ffuf
    + golang
    + entre otras...
- Actualización de Wordlists
    + /usr/share/wordlist
    + /usr/share/seclists
- Herramientas desde github (/opt):
    + Dirsearch
    + PowerSploit
    + pspy
    + Wpseku
    + LinEnum
    + Airgeddon
    + CrackMapExec
    + GTFOBLookup
    + entre otras...

> Con el tiempo iré actualizando el repositorio...