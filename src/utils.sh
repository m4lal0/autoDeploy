#!/bin/bash
#by @m4lal0

### Instalación de paquetes extras
function installPackages(){
	section "COMENZANDO ACTUALIZAR REPOSITORIOS"
	checkInternet
	info "Descargando otros paquetes"
	apt install -y $PACKAGES_LIST > /dev/null 2>&1
	if [ $? -ne 0 ]; then
		apt update > /dev/null 2>&1
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
	## Instalación de NordVPN
	info "Instalando NordVPN"
	NordVPN_url=$(curl -sSL "https://repo.nordvpn.com/deb/nordvpn/debian/pool/main" | grep 'nordvpn-release*' | awk '{print $2}' | tr '><' ' ' | awk '{print $2}')
	cd /tmp/ 2>/dev/null
	wget "https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/$NordVPN_url" > /dev/null 2>&1
	dpkg -i $NordVPN_url > /dev/null 2>&1
	apt-get update -y > /dev/null 2>&1
	apt-get install nordvpn -y > /dev/null 2>&1
	if [ $? -ne 0 ]; then
		apt --fix-broken install -y > /dev/null 2>&1
		apt-get install nordvpn -y > /dev/null 2>&1
	fi
	check "Al instalar NordVPN"
	## Instalacion Brave
	info "Instalando Brave"
	curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add - > /dev/null 2>&1
	echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list > /dev/null 2>&1
	apt-get update -y > /dev/null 2>&1
	apt-get install brave-browser -y > /dev/null 2>&1
	if [ $? -ne 0 ]; then
		apt --fix-broken install -y > /dev/null 2>&1
		apt-get install brave-browser -y > /dev/null 2>&1
	fi
	check "Al instalar Brave"
	## Instalacion Pyrit
	info "Instalando Pyrit"
	cd /tmp/ ; wget http://ftp.mx.debian.org/debian/pool/main/p/pyrit/pyrit_0.5.1+git20180801-1_amd64.deb > /dev/null 2>&1
	dpkg -i /tmp/pyrit_0.5.1+git20180801-1_amd64.deb > /dev/null 2>&1
	check "Al instalar Pyrit"
	## Instalacion Scapy-2.4.2
	info "Instalando Scapy 2.4.2"
	cd /tmp/ ; wget https://github.com/secdev/scapy/archive/v2.4.2.zip > /dev/null 2>&1
	unzip v2.4.2.zip > /dev/null 2>&1
	cd scapy-2.4.2 && ./setup.py install > /dev/null 2>&1
	check "Al instalar Scapy 2.4.2"

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
    cd /usr/share/wordlists 2>/dev/null
    gunzip rockyou.txt.gz > /dev/null 2>&1
    check "Descomprimir archivo rockyou en /usr/share/wordlist/"
    cd 2>/dev/null
	## Hakrawler
	info "Instalando Hakrawler"
	cd /tmp/ 2>/dev/null
	go get github.com/hakluke/hakrawler > /dev/null 2>&1
	mv ~/go/bin/hakrawler /usr/local/bin > /dev/null 2>&1
	check "Agregando la aplicación Hakrawler"
	## hakrevdns
	info "Instalando hakrevdns"
	go get github.com/hakluke/hakrevdns > /dev/null 2>&1
	mv ~/go/bin/hakrevdns /usr/local/bin > /dev/null 2>&1
	check "Agregando la aplicación hakrevdns"
	## assetfinder
	info "Instalando assetfinder"
	go get -u github.com/tomnomnom/assetfinder > /dev/null 2>&1
	mv ~/go/bin/assetfinder /usr/local/bin > /dev/null 2>&1
	check "Agregando la aplicación assetfinder"

## Git clone con instalación aparte
	info "Creando directorios de aplicativos"
	mkdir {$EVASION_PATH,$PRIVESCLIN_PATH,$PRIVESCWIN_PATH,$OSINT_PATH,$UTILITIES_PATH,$WEB_PATH,$WIFI_PATH,$WORDPRESS_PATH} 2>/dev/null
	check "Al crear directorios"
	## Wpseku
	info "Descargando wpseku"
	cd $WORDPRESS_PATH 2>/dev/null
	git clone --depth 1 https://github.com/m4ll0k/WPSeku.git wpseku > /dev/null 2>&1
	cd wpseku 2>/dev/null
	pip3 install -r requirements.txt > /dev/null 2>&1
	check "Agregando la aplicación wpseku"
	## Sherlock-Project
	info "Descargando sherlock-project"
	cd $OSINT_PATH 2>/dev/null
	git clone --depth 1 https://github.com/sherlock-project/sherlock.git > /dev/null 2>&1
	cd sherlock 2>/dev/null
	python3 -m pip install -r requirements.txt  > /dev/null 2>&1
	check "Agregando la aplicación sherlock-project"
	## Impacket Python
	info "Descargando Impacket Python"
	cd $UTILITIES_PATH 2>/dev/null
	git clone https://github.com/SecureAuthCorp/impacket > /dev/null 2>&1
	cd impacket 2>/dev/null
	python3 setup.py install > /dev/null 2>&1
	check "Agregando Impacket Python"
	## GTFOBLookup
	info "Descargando GTFOBLookup"
	cd $UTILITIES_PATH 2>/dev/null
	git clone --depth 1 https://github.com/nccgroup/GTFOBLookup > /dev/null 2>&1
	cd GTFOBLookup 2>/dev/null
	pip3 install -r requirements.txt > /dev/null 2>&1
	python3 gtfoblookup.py update > /dev/null 2>&1
	check "Agregando GTFOBLookup"
	## SocialFish
	info "Descargando SocialFish"
	cd $UTILITIES_PATH 2>/dev/null
	git clone --depth 1 https://github.com/UndeadSec/SocialFish > /dev/null 2>&1
	cd SocialFish 2>/dev/null
	python3 -m pip install -r requirements.txt > /dev/null 2>&1
	check "Agregando SocialFish"
	## CRLFuzz
	info "Descargando CRLFuzz"
	cd /tmp/ 2>/dev/null
	git clone --depth 1 https://github.com/dwisiswant0/crlfuzz > /dev/null 2>&1
	cd /tmp/crlfuzz/cmd/crlfuzz 2>/dev/null
	go build . > /dev/null 2>&1
	mv crlfuzz /usr/local/bin > /dev/null 2>&1
	check "Agregando CRLFuzz"
	## brutemap
	info "Descargando brutemap"
	cd $WEB_PATH 2>/dev/null
	git clone --depth 1 https://github.com/brutemap-dev/brutemap > /dev/null 2>&1
	cd brutemap 2>/dev/null
	pip install -r requirements.txt > /dev/null 2>&1
	check "Agregando brutemap"
	## CWFF
	info "Descargando CWFF"
	cd $UTILITIES_PATH 2>/dev/null
	git clone --depth 1 https://github.com/D4Vinci/CWFF > /dev/null 2>&1
	cd CWFF 2>/dev/null
	python3 -m pip install -r requirements.txt > /dev/null 2>&1
	check "Agregando CWFF"
	## fuzzdb
	info "Descargando wordlists fuzzdb"
	cd /usr/share 2>/dev/null
	git clone --depth 1 https://github.com/fuzzdb-project/fuzzdb > /dev/null 2>&1
	ln -s /usr/share/fuzzdb /usr/share/wordlists > /dev/null 2>&1
	check "Agregando wordlist en /usr/share/wordlist/"
	## Xerosploit
	info "Descargando Xerosploit"
	cd $WIFI_PATH 2>/dev/null
	git clone --depth 1 https://github.com/LionSec/xerosploit > /dev/null 2>&1
	cd xerosploit && echo -e "1" | sudo python install.py > /dev/null 2>&1
	check "Agregando Xerosploit"
	## Vulnx
	info "Descargando Vulnx"
	cd $WORDPRESS_PATH 2>/dev/null
	git clone --depth 1 https://github.com/anouarbensaad/vulnx > /dev/null 2>&1
	cd vulnx && ./install.sh > /dev/null 2>&1
	check "Agregando Vulnx"
	## bashtop
	info "Descargando BashTOP"
	cd $UTILITIES_PATH 2>/dev/null
	git clone https://github.com/aristocratos/bashtop.git > /dev/null 2>&1
	cd bashtop && sudo make install > /dev/null 2>&1
	check "Agregando BashTOP"

## Descarga usando wget
	## psPY
	info "Descargando pspy"
	cd $PRIVESCLIN_PATH 2>/dev/null
	mkdir pspy > /dev/null 2>&1
	cd pspy 2>/dev/null
	wget https://github.com/DominicBreuker/pspy/releases/download/v1.2.0/pspy32 > /dev/null 2>&1
	check "Agregando la aplicación pspy32"
	wget https://github.com/DominicBreuker/pspy/releases/download/v1.2.0/pspy64 > /dev/null 2>&1
	check "Agregando la aplicación pspy64"
	## ffuf - Fuzz Faster U Fool
	info "Descargando ffuf"
	cd $WEB_PATH 2>/dev/null
	mkdir ffuf; cd ffuf 2>/dev/null
	wget https://github.com/ffuf/ffuf/releases/download/v1.1.0/ffuf_1.1.0_linux_amd64.tar.gz > /dev/null 2>&1
	tar -xzf ffuf_1.1.0_linux_amd64.tar.gz && rm ffuf_1.1.0_linux_amd64.tar.gz > /dev/null 2>&1
	check "Agregando la aplicación ffuf"
	## Unix-Privesc-Check-PentestMonkey
	info "Descargando unix-privesc-check"
	cd $PRIVESCLIN_PATH 2>/dev/null
	wget http://pentestmonkey.net/tools/unix-privesc-check/unix-privesc-check-1.4.tar.gz > /dev/null 2>&1
	tar -xzf unix-privesc-check-1.4.tar.gz && rm unix-privesc-check-1.4.tar.gz > /dev/null 2>&1
	check "Agregando la aplicación unix-privesc-check"
	## SubFinder
	info "Instalando subFinder"
	cd /tmp/ 2>/dev/null
	subfinder_url=$(curl --silent 'https://github.com/projectdiscovery/subfinder/releases' | grep -E 'subfinder_?[0-9].*_linux_amd64.tar.gz' | head -n 1 | awk -F '\"' '{print $2}')
	subfinder_file=$(curl --silent 'https://github.com/projectdiscovery/subfinder/releases' | grep -E 'subfinder_?[0-9].*_linux_amd64.tar.gz' | head -n 1 | awk -F '\"' '{print $2}' | tr '/' ' ' | awk 'NF{print $NF}')
	wget "https://github.com$subfinder_url" > /dev/null 2>&1
	tar -xzf /tmp/$subfinder_file > /dev/null 2>&1
	mv /tmp/subfinder /usr/local/bin/ > /dev/null 2>&1
	check "Agregando la aplicación subFinder"
	## httpx
	info "Instalando httpx"
	cd /tmp/ 2>/dev/null
	httpx_url=$(curl --silent 'https://github.com/projectdiscovery/httpx/releases' | grep -E 'httpx_?[0-9].*_linux_amd64.tar.gz' | head -n 1 | awk -F '\"' '{print $2}')
	httpx_file=$(curl --silent 'https://github.com/projectdiscovery/httpx/releases' | grep -E 'httpx_?[0-9].*_linux_amd64.tar.gz' | head -n 1 | awk -F '\"' '{print $2}' | tr '/' ' ' | awk 'NF{print $NF}')
	wget "https://github.com$httpx_url" > /dev/null 2>&1
	tar -xzf /tmp/$httpx_file > /dev/null 2>&1
	mv /tmp/httpx /usr/local/bin > /dev/null 2>&1
	check "Agregando la aplicación httpx"
	## CrackMapExec
	info "Descargando CrackMapExec"
	cd /tmp/ 2>/dev/null
	cme_url=$(curl --silent 'https://github.com/byt3bl33d3r/CrackMapExec/releases' | grep -E 'cme-ubuntu*.*.zip' | head -n 1 | awk -F '\"' '{print $2}')
	cme_file=$(curl --silent 'https://github.com/byt3bl33d3r/CrackMapExec/releases' | grep -E 'cme-ubuntu*.*.zip' | head -n 1 | awk -F '\"' '{print $2}' | tr '/' ' ' | awk 'NF{print $NF}')
	cmedb_url=$(curl --silent 'https://github.com/byt3bl33d3r/CrackMapExec/releases' | grep -E 'cmedb-ubuntu.latest.zip' | head -n 1 | awk -F '\"' '{print $2}')
	cmedb_file=$(curl --silent 'https://github.com/byt3bl33d3r/CrackMapExec/releases' | grep -E 'cmedb-ubuntu.latest.zip' | head -n 1 | awk -F '\"' '{print $2}' | tr '/' ' ' | awk 'NF{print $NF}')
	wget "https://github.com$cme_url" -O /tmp/$cme_file > /dev/null 2>&1
	wget "https://github.com$cmedb_url" -O /tmp/$cmedb_file > /dev/null 2>&1
	unzip /tmp/$cme_file > /dev/null 2>&1
	unzip /tmp/$cmedb_file > /dev/null 2>&1
	mv /tmp/cme /usr/local/bin > /dev/null 2>&1
	chmod 755 /usr/local/bin/cme > /dev/null 2>&1
	check "Agregando CrackMapExec"
	mv /tmp/cmedb /usr/local/bin > /dev/null 2>&1
	chmod 755 /usr/local/bin/cmedb > /dev/null 2>&1
	check "Agregando CrackMapExec DB"
	## go-dork
	info "Descargando go-Dork"
	cd /tmp/ 2>/dev/null
	godork_url=$(curl --silent 'https://github.com/dwisiswant0/go-dork/releases' | grep -E 'go-dork_?[0-9].*_linux_amd64.tar.gz' | head -n 1 | awk -F '\"' '{print $2}')
	godork_file=$(curl --silent 'https://github.com/dwisiswant0/go-dork/releases' | grep -E 'go-dork_?[0-9].*_linux_amd64.tar.gz' | head -n 1 | awk -F '\"' '{print $2}' | tr '/' ' ' | awk 'NF{print $NF}')
	wget "https://github.com$godork_url" -O /tmp/$godork_file > /dev/null 2>&1
	tar -xzf /tmp/$godork_file > /dev/null 2>&1
	mv /tmp/go-dork /usr/local/bin > /dev/null 2>&1
	check "Agregando go-Dork"
	## BruteShark
	info "Descargando BruteShark"
	cd $UTILITIES_PATH && mkdir BruteShark 2>/dev/null
	cd BruteShark 2>/dev/null
	wget https://github.com/odedshimon/BruteShark/releases/latest/download/BruteSharkCli > /dev/null 2>&1
	chmod +x BruteSharkCli > /dev/null 2>&1
	check "Agregando BruteShark"
	## naabu
	info "Descargando naabu"
	cd /tmp/ 2>/dev/null
	naabu_url=$(curl --silent 'https://github.com/projectdiscovery/naabu/releases' | grep -E 'naabu_?[0-9].*_linux_amd64.tar.gz' | head -n 1 | awk -F '\"' '{print $2}')
	naabu_file=$(curl --silent 'https://github.com/projectdiscovery/naabu/releases' | grep -E 'naabu_?[0-9].*_linux_amd64.tar.gz' | head -n 1 | awk -F '\"' '{print $2}' | tr '/' ' ' | awk 'NF{print $NF}')
	wget "https://github.com$naabu_url" -O /tmp/$naabu_file > /dev/null 2>&1
	tar -xzf /tmp/$naabu_file > /dev/null 2>&1
	mv /tmp/naabu /usr/local/bin > /dev/null 2>&1
	check "Agregando naabu"
	## evine
	info "Descargando evine"
	evine_url=$(curl --silent 'https://github.com/saeeddhqan/evine/releases' | grep -E 'evine_linux_amd64.tar.xz' | head -n 1 | awk -F '\"' '{print $2}')
	evine_file=$(curl --silent 'https://github.com/saeeddhqan/evine/releases' | grep -E 'evine_linux_amd64.tar.xz' | head -n 1 | awk -F '\"' '{print $2}' | tr '/' ' ' | awk 'NF{print $NF}')
	wget "https://github.com$evine_url" -O /tmp/$evine_file > /dev/null 2>&1
	tar -xJf /tmp/$evine_file > /dev/null 2>&1
	mv /tmp/evine /usr/local/bin > /dev/null 2>&1
	check "Agregando evine"
	## tempomail
	info "Descargando tempomail"
	cd /tmp/ 2>/dev/null
	tempomail_url=$(curl --silent 'https://github.com/kavishgr/tempomail/releases' | grep -E 'linux-amd64-tempomail.tgz' | head -n 1 | awk -F '\"' '{print $2}')
	wget "https://github.com$tempomail_url" > /dev/null 2>&1
	tar -xzf linux-amd64-tempomail.tgz && mv tempomail /usr/local/bin/ > /dev/null 2>&1
	check "Agregando la aplicación tempomail"
	## dnsx
	info "Descargando dnsx"
	dnsx_url=$(curl --silent 'https://github.com/projectdiscovery/dnsx/releases/' | grep -E 'dnsx_1.0.1_linux_amd64.tar.gz' | head -n 1 | awk -F '\"' '{print $2}')
	dnsx_file=$(curl --silent 'https://github.com/projectdiscovery/dnsx/releases/' | grep -E 'dnsx_1.0.1_linux_amd64.tar.gz' | head -n 1 | awk -F '\"' '{print $2}' | tr '/' ' ' | awk 'NF{print $NF}')
	wget "https://github.com$dnsx_url" -O /tmp/$dnsx_file > /dev/null 2>&1
	tar -xzf /tmp/$dnsx_file > /dev/null 2>&1
	mv /tmp/dnsx /usr/local/bin > /dev/null 2>&1
	check "Agregando dnsx"

## Descarga de otras herramientas de GitHub sin instalación
	for gitap in $(cat $GIT_TOOLS_LIST); do
		url=$(echo $gitap | cut -d '|' -f2)
		dir=$(echo $gitap | cut -d '|' -f1)
		name=$(echo $url | tr '/' ' ' | cut -d ' ' -f5)
		cd $GIT_TOOLS_PATH/$dir 2>/dev/null
		info "Descargando $name"
		git clone --depth 1 $url > /dev/null 2>&1
		check "Agregando la aplicación $name"
	done
	ln -s $WEB_PATH/dirsearch/dirsearch.py /bin/dirsearch > /dev/null 2>&1
	check "Redireccionando el archivo dirsearch a /bin"
}