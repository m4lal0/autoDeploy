#!/bin/bash
#by @M4lal0

### Instalación de paquetes extras
function installPackages(){
	section "COMENZANDO ACTUALIZAR REPOSITORIOS"
	checkInternet
	info "Descargando otros paquetes"
	apt install -y $PACKAGES_LIST > /dev/null 2>&1
	apt --fix-broken install -y > /dev/null 2>&1
	if [ $? -ne 0 ]; then
		apt install -y $PACKAGES_LIST > /dev/null 2>&1
	fi
	apt --fix-broken install -y > /dev/null 2>&1
	check "Instalando paquetes adicionales"
	## Actualizar paquetes
	info "Actualizando paquetes"
	apt update > /dev/null 2>&1
	check "Al actualizar paquetes"
	## Descartar paquetes obsoletos
	info "Eliminando paquetes sin usar (apt autoremove)"
	apt autoremove -y > /dev/null 2>&1
	check "Al eliminar paquetes sin uso"
}

### Instalación de otras aplicaciones
function installApps(){
	section "COMENZANDO INSTALACIÓN DE UTILIDADES"
	checkInternet
	info "Instalando Google Chrome"
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O /tmp/chrome.deb > /dev/null 2>&1
	check "Al descargar Google Chrome"
	dpkg -i /tmp/chrome.deb > /dev/null 2>&1
	check "Al instalar Google Chrome"
	info "Instalando ZenMap"
	wget https://nmap.org/dist/zenmap-7.80-1.noarch.rpm -O /tmp/zenmap-7.80-1.noarch.rpm > /dev/null 2>&1
	check "Al descargar ZenMap"
	cd /tmp/ ; alien /tmp/zenmap-7.80-1.noarch.rpm > /dev/null 2>&1
	check "Al tranformar archivo de ZenMap"
	dpkg -i /tmp/zenmap_7.80-2_all.deb > /dev/null 2>&1
	check "Al instalar ZenMap"

	info "Instalando Gotop"
	cd $SCRIPT_PATH ; git clone --depth 1 https://github.com/cjbassi/gotop /tmp/gotop > /dev/null 2>&1
	check "Clonando el repositorio de Gotop"
	/tmp/gotop/scripts/download.sh > /dev/null 2>&1
	check "En la instalación de Gotop"
	mv gotop /usr/local/bin 2>/dev/null
	check "Al mover el binario de gotop a /usr/local/bin"

	## Instalación de paquetes con pip & pip3
	for ap in $(cat $PIP_TOOLS_LIST); do
		info "Instalando $(echo $ap | cut -d ':' -f 2)"
		$(echo $ap | cut -d ':' -f 1) install $(echo $ap | cut -d ':' -f 2) > /dev/null 2>&1
		check "Instalando $(echo $ap | cut -d ':' -f 2) (root)"
		sudo -u $USERNAME $(echo $ap | cut -d ':' -f 1) install $(echo $ap | cut -d ':' -f 2) > /dev/null 2>&1
		check "Instalando $(echo $ap | cut -d ':' -f 2) ($USERNAME)"
	done
}

### Instalacion de aplicaciones terceras en /opt/
function gitTools(){
	section "COMENZANDO INSTALACIÓN DE APLICACIONES DE TERCEROS"
	checkInternet
	info "Descargando netcat 64bits"
	wget https://eternallybored.org/misc/netcat/netcat-win32-1.11.zip -O /tmp/netcat.zip > /dev/null 2>&1
	check "Al descargar netcat"
	cd /tmp/ ; unzip /tmp/netcat.zip > /dev/null 2>&1
	check "Al descomprimir netcat"
	sudo cp /tmp/netcat-1.11/nc64.exe /usr/share/windows-binaries/nc64.exe > /dev/null 2>&1
	check "Al copiar netcat en /usr/share/windows-binaries/"
	## Descomprimir wordlist rockyou
    info "Descomprimiendo wordlist rockyou"
    cd /usr/share/wordlists > /dev/null 2>&1
    gunzip rockyou.txt.gz > /dev/null 2>&1
    check "Descomprimir archivo rockyou en /usr/share/wordlist/"
    cd > /dev/null 2>&1
	## SubFinder
	info "Instalando subFinder"
	cd /tmp/ > /dev/null 2>&1
	subfinder_url=$(curl --silent 'https://github.com/projectdiscovery/subfinder/releases' | grep -E 'subfinder_?[0-9].*_linux_amd64.tar.gz' | head -n 1 | awk -F '\"' '{print $2}')
	subfinder_file=$(curl --silent 'https://github.com/projectdiscovery/subfinder/releases' | grep -E 'subfinder_?[0-9].*_linux_amd64.tar.gz' | head -n 1 | awk -F '\"' '{print $2}' | tr '/' ' ' | awk 'NF{print $NF}')
	wget "https://github.com$subfinder_url" > /dev/null 2>&1
	tar -xzvf /tmp/$subfinder_file > /dev/null 2>&1
	mv /tmp/subfinder /usr/local/bin/ > /dev/null 2>&1
	check "Agregando la aplicación subFinder"
	## Hakrawler
	info "Instalando Hakrawler"
	cd /tmp/ > /dev/null 2>&1
	go get github.com/hakluke/hakrawler > /dev/null 2>&1
	mv ~/go/bin/hakrawler /usr/local/bin > /dev/null 2>&1
	check "Agregando la aplicación Hakrawler"

## Git clone con instalación aparte
	info "Creando directorios de aplicativos"
	cd $GIT_TOOLS_PATH > /dev/null 2>&1
	mkdir {Evasion,PrivEsc-Lin,PrivEsc-Win,OSINT,Utilities,Web,Wifi} 2>&1
	cd Web ; mkdir Wordpress 2>&1
	check "Al crear directorios"
	## Wpseku
	cd $GIT_TOOLS_PATH/Web/Wordpress > /dev/null 2>&1
	info "Descargando wpseku"
	git clone --depth 1 https://github.com/m4ll0k/WPSeku.git wpseku > /dev/null 2>&1
	cd wpseku > /dev/null 2>&1
	pip3 install -r requirements.txt > /dev/null 2>&1
	check "Agregando la aplicación wpseku"
	## Sherlock-Project
	cd $GIT_TOOLS_PATH/OSINT > /dev/null 2>&1
	info "Descargando sherlock-project"
	git clone --depth 1 https://github.com/sherlock-project/sherlock.git > /dev/null 2>&1
	cd sherlock > /dev/null 2>&1
	python3 -m pip install -r requirements.txt  > /dev/null 2>&1
	check "Agregando la aplicación sherlock-project"
	## Impacket Python
	cd $GIT_TOOLS_PATH/Utilities > /dev/null 2>&1
	info "Descargando Impacket Python"
	git clone https://github.com/SecureAuthCorp/impacket > /dev/null 2>&1
	cd impacket > /dev/null 2>&1
	python3 setup.py install > /dev/null 2>&1
	check "Agregando Impacket Python"
	## CrackMapExec
	cd $GIT_TOOLS_PATH/Utilities > /dev/null 2>&1
	info "Descargando CrackMapExec"
	git clone --recursive https://github.com/byt3bl33d3r/CrackMapExec > /dev/null 2>&1
	cd CrackMapExec > /dev/null 2>&1
	python3 setup.py install > /dev/null 2>&1
	check "Agregando CrackMapExec"
	## GTFOBLookup
	cd $GIT_TOOLS_PATH/Utilities > /dev/null 2>&1
	info "Descargando GTFOBLookup"
	git clone --depth 1 https://github.com/nccgroup/GTFOBLookup > /dev/null 2>&1
	cd GTFOBLookup > /dev/null 2>&1
	pip3 install -r requirements.txt > /dev/null 2>&1
	python3 gtfoblookup.py update > /dev/null 2>&1
	check "Agregando GTFOBLookup"
	## SocialFish
	cd $GIT_TOOLS_PATH/Utilities > /dev/null 2>&1
	info "Descargando SocialFish"
	git clone --depth 1 https://github.com/UndeadSec/SocialFish > /dev/null 2>&1
	cd SocialFish > /dev/null 2>&1
	python3 -m pip install -r requirements.txt > /dev/null 2>&1
	check "Agregando SocialFish"
	## CRLFuzz
	cd /tmp/ > /dev/null 2>&1
	info "Descargando CRLFuzz"
	git clone https://github.com/dwisiswant0/crlfuzz > /dev/null 2>&1
	cd /tmp/crlfuzz/cmd/crlfuzz > /dev/null 2>&1
	go build . > /dev/null 2>&1
	mv crlfuzz /usr/local/bin > /dev/null 2>&1
	check "Agregando CRLFuzz"

## Descarga usando wget
	## psPY
	cd $GIT_TOOLS_PATH/PrivEsc-Lin > /dev/null 2>&1
	info "Descargando pspy"
	mkdir pspy > /dev/null 2>&1
	cd pspy > /dev/null 2>&1
	wget https://github.com/DominicBreuker/pspy/releases/download/v1.2.0/pspy32 > /dev/null 2>&1
	check "Agregando la aplicación pspy32"
	wget https://github.com/DominicBreuker/pspy/releases/download/v1.2.0/pspy64 > /dev/null 2>&1
	check "Agregando la aplicación pspy64"
	## ffuf - Fuzz Faster U Fool
	cd $GIT_TOOLS_PATH/Web > /dev/null 2>&1
	info "Descargando ffuf"
	mkdir ffuf; cd ffuf > /dev/null 2>&1
	wget https://github.com/ffuf/ffuf/releases/download/v1.1.0/ffuf_1.1.0_linux_amd64.tar.gz > /dev/null 2>&1
	tar -xzf ffuf_1.1.0_linux_amd64.tar.gz && rm ffuf_1.1.0_linux_amd64.tar.gz > /dev/null 2>&1
	check "Agregando la aplicación ffuf"
	## Unix-Privesc-Check-PentestMonkey
	cd $GIT_TOOLS_PATH/PrivEsc-Lin > /dev/null 2>&1
	info "Descargando unix-privesc-check"
	wget http://pentestmonkey.net/tools/unix-privesc-check/unix-privesc-check-1.4.tar.gz > /dev/null 2>&1
	tar -xzf unix-privesc-check-1.4.tar.gz && rm unix-privesc-check-1.4.tar.gz > /dev/null 2>&1
	check "Agregando la aplicación unix-privesc-check"

## Descarga de otras herramientas de GitHub sin instalación
	for gitap in $(cat $GIT_TOOLS_LIST); do
		url=$(echo $gitap | cut -d '|' -f2)
		dir=$(echo $gitap | cut -d '|' -f1)
		name=$(echo $url | tr '/' ' ' | cut -d ' ' -f5)
		cd $GIT_TOOLS_PATH/$dir > /dev/null 2>&1
		info "Descargando $name"
		git clone --depth 1 $url > /dev/null 2>&1
		check "Agregando la aplicación $name"
	done
	ln -s $GIT_TOOLS_PATH/Web/dirsearch/dirsearch.py /bin/dirsearch > /dev/null 2>&1
	check "Redireccionando el archivo dirsearch a /bin"

	info "Actualizacion de updatedb"
	sudo updatedb > /dev/null 2>&1
	check "Ejecutando updatedb"
}