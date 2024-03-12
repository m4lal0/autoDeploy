# autoDeploy

[![GitHub top language](https://img.shields.io/github/languages/top/m4lal0/autoDeploy?logo=gnu-bash&style=for-the-badge)](#)
[![GitHub repo size](https://img.shields.io/github/repo-size/m4lal0/autoDeploy?logo=webpack&style=for-the-badge)](#)
[![Developed on Kali Linux](https://img.shields.io/badge/Developed_on-Kali_Linux-purple?style=for-the-badge&logo=kali-linux)](#)
[![By](https://img.shields.io/badge/By-m4lal0-green?style=for-the-badge&logo=github)](#)

![autoDeploy](./images/autodeploy.png)

<h4 align="center">AutoDeploy es un script en bash que permite instalar una capa de personalización en Kali Linux OS. Instala diferentes plugins, aplicaciones y utilidades para tener un entorno más agradable para trabajar.</h4><br>

---

## Descarga

Descargar el proyecto y darle permisos de ejecución:

```
git clone https://github.com/m4lal0/autoDeploy
cd autoDeploy; chmod +x autoDeploy.sh
```

## ¿Cómo usarlo?

```
                             __              _______                    __                   
                            |  \            |       \                  |  \                  
          ______  __    __ _| ▓▓_    ______ | ▓▓▓▓▓▓▓\ ______   ______ | ▓▓ ______  __    __ 
         |      \|  \  |  \   ▓▓ \  /      \| ▓▓  | ▓▓/      \ /      \| ▓▓/      \|  \  |  \
          \▓▓▓▓▓▓\ ▓▓  | ▓▓\▓▓▓▓▓▓ |  ▓▓▓▓▓▓\ ▓▓  | ▓▓  ▓▓▓▓▓▓\  ▓▓▓▓▓▓\ ▓▓  ▓▓▓▓▓▓\ ▓▓  | ▓▓
         /      ▓▓ ▓▓  | ▓▓ | ▓▓ __| ▓▓  | ▓▓ ▓▓  | ▓▓ ▓▓    ▓▓ ▓▓  | ▓▓ ▓▓ ▓▓  | ▓▓ ▓▓  | ▓▓
        |  ▓▓▓▓▓▓▓ ▓▓__/ ▓▓ | ▓▓|  \ ▓▓__/ ▓▓ ▓▓__/ ▓▓ ▓▓▓▓▓▓▓▓ ▓▓__/ ▓▓ ▓▓ ▓▓__/ ▓▓ ▓▓__/ ▓▓
         \▓▓    ▓▓\▓▓    ▓▓  \▓▓  ▓▓\▓▓    ▓▓ ▓▓    ▓▓\▓▓     \ ▓▓    ▓▓ ▓▓\▓▓    ▓▓\▓▓    ▓▓
          \▓▓▓▓▓▓▓ \▓▓▓▓▓▓    \▓▓▓▓  \▓▓▓▓▓▓ \▓▓▓▓▓▓▓  \▓▓▓▓▓▓▓ ▓▓▓▓▓▓▓ \▓▓ \▓▓▓▓▓▓ _\▓▓▓▓▓▓▓
                                                              | ▓▓                 |  \__| ▓▓
                                                              | ▓▓                  \▓▓    ▓▓
                                                               \▓▓                   \▓▓▓▓▓▓ 

         Script para personalizar el entorno de trabajo de Kali Linux .:.:. By @m4lal0 .:.:. 


[!] Uso:

        ./autoDeploy.sh [OPCION]

OPCIONES:
        -i, --install         Instalación completa de la capa de personalización.
              terminal:       Instalación solamente de la personalización de la terminal y escritorio.
              apps:           Instalación solamente de los programas de terceros.
        -d, --delete          Eliminar configuración de Escritorio y directorios de los aplicativos de terceros.
        -h, --help            Mostrar este panel de ayuda.
```

El script cuenta con **3** modos de instalación:
##### Instalación completa
```sh
./autoDeploy.sh --install
```
##### Instalar personalización de terminal y escritorio xfce
```sh
./autoDeploy.sh --install terminal
```
##### Instalar aplicaciones de terceros
```sh
./autoDeploy.sh --install apps
```

Al inicio solicitará unos datos para el proceso de instalación, el resto de la ejecución debería de realizarse automáticamente sin necesitar interacción del usuario. Si algún paso de la instalación falla, se almacena una copia del error en el fichero **error.log** para que estos puedan ser solucionados posteriormente de forma manual.