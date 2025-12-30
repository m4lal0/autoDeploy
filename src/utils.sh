#!/usr/bin/env bash
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
	info "Actualizar paquetes"
	apt update > /dev/null 2>&1
	check "Actualizando paquetes"
	## Descartar paquetes obsoletos
	info "Eliminar paquetes sin usar (apt autoremove)"
	apt autoremove -y > /dev/null 2>&1
	check "Eliminando paquetes sin uso"
}

### Instalación de otras aplicaciones
function installWebTools(){
	section "COMENZANDO INSTALACIÓN DE UTILIDADES"
	checkInternet

	## Instalacion de Extensiones en Firefox
	info "Instalar extensiones en Firefox"
	if [[ -d $HOME_PATH/.mozilla ]];then
		if [[ -d $HOME_PATH/.mozilla/firefox/*.default-esr ]];then
			if [[ ! -d $HOME_PATH/.mozilla/firefox/*.default-esr/extensions ]];then
				cd $HOME_PATH/.mozilla/firefox/*.default-esr ; mkdir extensions
				chown $USERNAME:$USERNAME extensions 2>/dev/null
				check "Creando directorio de extensiones"
			fi
		fi
	else
		##su $USERNAME -c "nohup /bin/firejail /usr/bin/firefox &>/dev/null &; sleep 3; kill %1"
		su $USERNAME -c "nohup /usr/bin/firefox &>/dev/null &; sleep 3; kill %1"
	fi

	if [[ -d $HOME_PATH/.mozilla ]];then
		if [[ ! -d $HOME_PATH/.mozilla/firefox/*.default-esr/extensions ]];then
			cd $HOME_PATH/.mozilla/firefox/*.default-esr ; mkdir extensions
			chown $USERNAME:$USERNAME extensions 2>/dev/null
			check "Creando directorio de extensiones"
		fi
	fi

	#Instalando extensión: Wappalyzer
	mkdir /tmp/extensions && cd /tmp/extensions 2>/dev/null
	mkdir wappalyzer && cd wappalyzer 2>/dev/null
	wget https://addons.mozilla.org/firefox/downloads/file/4498612/wappalyzer-6.10.83.xpi > /dev/null 2>&1
	cp wappalyzer-6.10.83.xpi wappalyzer@crunchlabz.com.xpi 2>/dev/null
	chown $USERNAME:$USERNAME wappalyzer@crunchlabz.com.xpi 2>/dev/null
	mv wappalyzer@crunchlabz.com.xpi $HOME_PATH/.mozilla/firefox/*.default-esr/extensions/ 2>/dev/null
	check "Instalando extensión Wappalyzer"

	#Instalando extensión: uBlock Origin
	cd /tmp/extensions 2>/dev/null
	mkdir ublock && cd ublock 2>/dev/null
	wget https://addons.mozilla.org/firefox/downloads/file/4237670/ublock_origin-1.56.0.xpi > /dev/null 2>&1
	cp ublock_origin-1.56.0.xpi uBlock0@raymondhill.net.xpi 2>/dev/null
	chown $USERNAME:$USERNAME uBlock0@raymondhill.net.xpi 2>/dev/null
	mv uBlock0@raymondhill.net.xpi $HOME_PATH/.mozilla/firefox/*.default-esr/extensions/ 2>/dev/null
	check "Instalando extensión uBlock Origin"

	#Instalando extensión: Privacy Badger
	cd /tmp/extensions 2>/dev/null
	mkdir privacybadger && cd privacybadger 2>/dev/null
	wget https://addons.mozilla.org/firefox/downloads/file/4232703/privacy_badger17-2024.2.6.xpi > /dev/null 2>&1
	cp privacy_badger17-2024.2.6.xpi jid1-MnnxcxisBPnSXQ@jetpack.xpi 2>/dev/null
	chown $USERNAME:$USERNAME jid1-MnnxcxisBPnSXQ@jetpack.xpi 2>/dev/null
	mv jid1-MnnxcxisBPnSXQ@jetpack.xpi $HOME_PATH/.mozilla/firefox/*.default-esr/extensions/ 2>/dev/null
	check "Instalando extensión Privacy Badger"

	#Instalando extensión: FoxyProxy
	cd /tmp/extensions 2>/dev/null
	mkdir foxyproxy && cd foxyproxy 2>/dev/null
	#wget https://addons.mozilla.org/firefox/downloads/file/4228676/foxyproxy_standard-8.9.xpi > /dev/null 2>&1
	wget https://github.com/rohsec/BetterBugBounty/raw/main/FoxyProxy/Firefox/foxyproxy_standard-7.5.1.xpi > /dev/null 2>&1
	#cp foxyproxy_standard-8.9.xpi foxyproxy@eric.h.jung.xpi 2>/dev/null
	cp foxyproxy_standard-7.5.1.xpi foxyproxy@eric.h.jung.xpi 2>/dev/null
	chown $USERNAME:$USERNAME foxyproxy@eric.h.jung.xpi 2>/dev/null
	mv foxyproxy@eric.h.jung.xpi $HOME_PATH/.mozilla/firefox/*.default-esr/extensions/ 2>/dev/null
	check "Instalando extensión FoxyProxy"

	#Instalando extensión: HackTools
	cd /tmp/extensions 2>/dev/null
	mkdir hacktools && cd hacktools 2>/dev/null
	wget https://addons.mozilla.org/firefox/downloads/file/3901885/hacktools-0.4.0.xpi > /dev/null 2>&1
	cp hacktools-0.4.0.xpi {f1423c11-a4e2-4709-a0f8-6d6a68c83d08}.xpi 2>/dev/null
	chown $USERNAME:$USERNAME \{f1423c11-a4e2-4709-a0f8-6d6a68c83d08\}.xpi 2>/dev/null
	mv \{f1423c11-a4e2-4709-a0f8-6d6a68c83d08\}.xpi $HOME_PATH/.mozilla/firefox/*.default-esr/extensions/ 2>/dev/null
	check "Instalando extensión HackTools"

	#Instalando extensión: IP Address and Domain Information
	cd /tmp/extensions 2>/dev/null
	mkdir ipaddress && cd ipaddress 2>/dev/null
	wget https://addons.mozilla.org/firefox/downloads/file/4366078/ip_address_and_domain_info-4.0.6.5.xpi > /dev/null 2>&1
	cp ip_address_and_domain_info-4.0.6.5.xpi jid0-jJRRRBMgoShUhb07IvnxTBAl29w@jetpack.xpi 2>/dev/null
	chown $USERNAME:$USERNAME jid0-jJRRRBMgoShUhb07IvnxTBAl29w@jetpack.xpi 2>/dev/null
	mv jid0-jJRRRBMgoShUhb07IvnxTBAl29w@jetpack.xpi $HOME_PATH/.mozilla/firefox/*.default-esr/extensions/ 2>/dev/null
	check "Instalando extensión IP Address and Domain Information"

	#Instalando extensión: Edit This Cookie2
	cd /tmp/extensions 2>/dev/null
	mkdir editcookie && cd editcookie 2>/dev/null
	wget https://addons.mozilla.org/firefox/downloads/file/3449327/etc2-1.5.0.xpi > /dev/null 2>&1
	cp etc2-1.5.0.xpi {ae627955-50e3-431c-b6c5-7cd912f961cb}.xpi 2>/dev/null
	chown $USERNAME:$USERNAME \{ae627955-50e3-431c-b6c5-7cd912f961cb\}.xpi 2>/dev/null
	mv \{ae627955-50e3-431c-b6c5-7cd912f961cb\}.xpi $HOME_PATH/.mozilla/firefox/*.default-esr/extensions/ 2>/dev/null
	check "Instalando extensión EditThisCookie2"

	#Instalando extensión: Custom UserAgent String
	cd /tmp/extensions  2>/dev/null
	mkdir useragent && cd useragent  2>/dev/null
	wget https://addons.mozilla.org/firefox/downloads/file/4098688/user_agent_string_switcher-0.5.0.xpi > /dev/null 2>&1
	cp user_agent_string_switcher-0.5.0.xpi {a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7}.xpi 2>/dev/null
	chown $USERNAME:$USERNAME \{a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7\}.xpi 2>/dev/null
	mv \{a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7\}.xpi $HOME_PATH/.mozilla/firefox/*.default-esr/extensions/ 2>/dev/null
	check "Instalando extensión Custom-UserAgent"

	#Instalando extenión: WhatRuns
	cd /tmp/extensions  2>/dev/null
	mkdir whatruns && cd whatruns  2>/dev/null
	wget https://addons.mozilla.org/firefox/downloads/file/3728170/whatruns-1.7.7.xpi > /dev/null 2>&1
	cp whatruns-1.7.7.xpi {66d854c2-fd1b-4857-bd0a-7d220e4834da}.xpi 2>/dev/null
	chown $USERNAME:$USERNAME \{66d854c2-fd1b-4857-bd0a-7d220e4834da\}.xpi 2>/dev/null
	mv \{66d854c2-fd1b-4857-bd0a-7d220e4834da\}.xpi $HOME_PATH/.mozilla/firefox/*.default-esr/extensions/ 2>/dev/null
	check "Instalando extensión WhatRuns"

	#Instalando extenión: WebGL Fingerprint Defender
	cd /tmp/extensions  2>/dev/null
	mkdir webgl && cd webgl  2>/dev/null
	wget https://addons.mozilla.org/firefox/downloads/file/4026370/webgl_fingerprint_defender-0.1.6.xpi > /dev/null 2>&1
	cp webgl_fingerprint_defender-0.1.6.xpi {2cf5dbed-78fe-4bd5-9524-38fdf837be98}.xpi 2>/dev/null
	chown $USERNAME:$USERNAME \{2cf5dbed-78fe-4bd5-9524-38fdf837be98\}.xpi 2>/dev/null
	mv \{2cf5dbed-78fe-4bd5-9524-38fdf837be98\}.xpi $HOME_PATH/.mozilla/firefox/*.default-esr/extensions/ 2>/dev/null
	check "Instalando extensión WebGL Fingerprint Defender"

	#Instalando extenión: Chameleon
	cd /tmp/extensions  2>/dev/null
	mkdir chameleon && cd chameleon  2>/dev/null
	wget https://addons.mozilla.org/firefox/downloads/file/4349329/chameleon_ext-0.22.65.1.xpi > /dev/null 2>&1
	cp chameleon_ext-0.22.65.1.xpi {3579f63b-d8ee-424f-bbb6-6d0ce3285e6a}.xpi 2>/dev/null
	chown $USERNAME:$USERNAME \{3579f63b-d8ee-424f-bbb6-6d0ce3285e6a\}.xpi 2>/dev/null
	mv \{3579f63b-d8ee-424f-bbb6-6d0ce3285e6a\}.xpi $HOME_PATH/.mozilla/firefox/*.default-esr/extensions/ 2>/dev/null
	check "Instalando extensión Chameleon"

	#Instalando extenión: CanvasBlocker
	cd /tmp/extensions  2>/dev/null
	mkdir canvasblocker && cd canvasblocker  2>/dev/null
	wget https://addons.mozilla.org/firefox/downloads/file/4262820/canvasblocker-1.10.1.xpi > /dev/null 2>&1
	cp canvasblocker-1.10.1.xpi CanvasBlocker@kkapsner.de.xpi 2>/dev/null
	chown $USERNAME:$USERNAME CanvasBlocker@kkapsner.de.xpi 2>/dev/null
	mv CanvasBlocker@kkapsner.de.xpi $HOME_PATH/.mozilla/firefox/*.default-esr/extensions/ 2>/dev/null
	check "Instalando extensión CanvasBlocker"

	#Instalando extensión: SingleFile
	cd /tmp/extensions  2>/dev/null
	mkdir singlefile && cd singlefile  2>/dev/null
	wget https://addons.mozilla.org/firefox/downloads/file/4465739/single_file-1.22.81.xpi > /dev/null 2>&1
	cp single_file-1.22.81.xpi {531906d3-e22f-4a6c-a102-8057b88a1a63}.xpi 2>/dev/null
	chown $USERNAME:$USERNAME \{531906d3-e22f-4a6c-a102-8057b88a1a63\}.xpi 2>/dev/null
	mv \{531906d3-e22f-4a6c-a102-8057b88a1a63\}.xpi $HOME_PATH/.mozilla/firefox/*.default-esr/extensions/ 2>/dev/null
	check "Instalando extensión SingleFile"

	## Instalacion Brave
	info "Instalar Brave"
	curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg 2>/dev/null
	echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list > /dev/null 2>&1
	check "Descargando Brave"
	apt update -y > /dev/null 2>&1
	apt install brave-browser -y > /dev/null 2>&1
	if [ $? -ne 0 ]; then
		apt --fix-broken install -y > /dev/null 2>&1
		apt-get install brave-browser -y > /dev/null 2>&1
	fi
	check "Instalando Brave"
}

function installPipTools(){
	## Instalación de paquetes con pip & pip3
	for ap in $(cat $PIP_TOOLS_LIST); do
		info "Instalando $(echo $ap | cut -d ':' -f 2)"
		$(echo $ap | cut -d ':' -f 1) install $(echo $ap | cut -d ':' -f 2) --break-system-packages > /dev/null 2>&1
		check "Instalando $(echo $ap | cut -d ':' -f 2) (root)"
		sudo -u $USERNAME $(echo $ap | cut -d ':' -f 1) install $(echo $ap | cut -d ':' -f 2) --break-system-packages > /dev/null 2>&1
		check "Instalando $(echo $ap | cut -d ':' -f 2) ($USERNAME)"
	done
}

function installGoTools(){
	## Instalación de paquetes con go
	for ap in $(cat $GO_TOOLS_LIST); do
		info "Instalando $(echo $ap | cut -d ':' -f 1)"
		go install $(echo $ap | cut -d ':' -f 2) > /dev/null 2>&1
		check "Instalando $(echo $ap | cut -d ':' -f 1) (root)"
	done
}

### Instalacion de aplicaciones terceras en /opt/
function installGitTools(){
	section "COMENZANDO INSTALACIÓN DE APLICACIONES DE TERCEROS"
	checkInternet
	info "Instalar Gotop"
	cd $SCRIPT_PATH ; git clone --depth 1 https://github.com/cjbassi/gotop /tmp/gotop > /dev/null 2>&1
	check "Clonando el repositorio de Gotop"
	/tmp/gotop/scripts/download.sh > /dev/null 2>&1
	check "Instalando Gotop"
	mv gotop /usr/local/bin 2>/dev/null
	check "Mover el binario de gotop a /usr/local/bin"
	info "Configurando netcat 64bits"
	wget https://eternallybored.org/misc/netcat/netcat-win32-1.11.zip -O /tmp/netcat.zip > /dev/null 2>&1
	check "Descargando netcat"
	cd /tmp/ ; unzip /tmp/netcat.zip > /dev/null 2>&1
	check "Descompirmiendo netcat"
	sudo cp /tmp/netcat-1.11/nc64.exe /usr/share/windows-resources/binaries/nc64.exe > /dev/null 2>&1
	check "Copiando netcat en /usr/share/windows-resources/binaries"
	chmod 755 /usr/share/windows-resources/binaries/nc64.exe 2>/dev/null
	check "Asignando permisos a nc64.exe"
	### WORDLISTS
	## Descomprimir wordlist rockyou
    info "Descomprimiendo wordlist rockyou"
    cd /usr/share/wordlists 2>/dev/null
    gunzip rockyou.txt.gz > /dev/null 2>&1
    check "Descomprimir archivo rockyou en /usr/share/wordlists/"
    cd 2>/dev/null
	## fuzzdb
	info "Descargando wordlists fuzzdb"
	cd /usr/share 2>/dev/null
	git clone --depth 1 https://github.com/fuzzdb-project/fuzzdb > /dev/null 2>&1
	ln -s `pwd`/fuzzdb /usr/share/wordlists > /dev/null 2>&1
	check "Agregando wordlist en /usr/share/wordlists/fuzzdb"
	## OneListForAll
	info "Descargando wordlists OneListForAll"
	cd /usr/share 2>/dev/null
	git clone --depth 1 https://github.com/six2dez/OneListForAll > /dev/null 2>&1
	ln -s `pwd`/OneListForAll /usr/share/wordlists > /dev/null 2>&1
	check "Agregando wordlist en /usr/share/wordlists/OneListForAll"
	## Kerberos-Enum-userlists
	info "Descargando wordlists Kerberos-Username-Enumeration"
	cd /usr/share 2>/dev/null
	git clone https://github.com/attackdebris/kerberos_enum_userlists > /dev/null 2>&1
	ln -s `pwd`/kerberos_enum_userlists /usr/share/wordlists > /dev/null 2>&1
	check "Agregando wordlist en /usr/share/wordlists/kerberos_enum_userlists"
	## IntruderPayloads
	info "Descargando wordlists IntruderPayloads"
	cd /usr/share 2>/dev/null
	git clone https://github.com/1N3/IntruderPayloads > /dev/null 2>&1
	rm /usr/share/IntruderPayloads/BurpsuiteIntruderPayloads.png /usr/share/IntruderPayloads/install.sh /usr/share/IntruderPayloads/OWASPTestingChecklist_v_1.0.xls /usr/share/IntruderPayloads/README.md /usr/share/IntruderPayloads/update.sh  2>/dev/null
	ln -s `pwd`/IntruderPayloads /usr/share/wordlists > /dev/null 2>&1
	check "Agregando wordlist en /usr/share/wordlists/IntruderPayloads"
	## LFI Server Configurations - Linux
	info "Descargando wordlists de Configuraciones de Servidores de Linux"
	wget https://raw.githubusercontent.com/DragonJAR/Security-Wordlist/main/LFI-WordList-Linux -O /usr/share/wordlists/LFI-WordList-Linux.txt > /dev/null 2>&1
	check "Agregando wordlist en /usr/share/wordlists/LFI-WordList-Linux.txt"
	## LFI Server Configurations - Windows
	info "Descargando wordlists de Configuraciones de Servidores de Windows"
	wget https://raw.githubusercontent.com/DragonJAR/Security-Wordlist/main/LFI-WordList-Windows -O /usr/share/wordlists/LFI-WordList-Windows.txt > /dev/null 2>&1
	check "Agregando wordlist en /usr/share/wordlists/LFI-WordList-Windows.txt"
	## Auto_Wordlists
	info "Descargando wordlist Auto_Wordlists"
	cd /usr/share 2>/dev/null
	git clone https://github.com/carlospolop/Auto_Wordlists > /dev/null 2>&1
	ln -s `pwd`/Auto_Wordlist /usr/share/wordlists > /dev/null 2>&1
	check "Agregando wordlist en /usr/share/wordlists/Auto_Wordlists"
	## JWT Secrets
	info "Descargando wordlist jwt_secrets"
	wget https://raw.githubusercontent.com/wallarm/jwt-secrets/refs/heads/master/jwt.secrets.list -O /usr/share/wordlists/jwt.secrets.list > /dev/null 2>&1
	check "Agregando wordlist en /usr/share/wordlists/jwt.secrets.list"
	## Others Wordlists
	info "Descargando otras wordlists"
	cd /usr/share 2>/dev/null
	mkdir trickest; cd trickest; git clone https://github.com/trickest/wordlists > /dev/null 2>&1
	cd wordlists; mv inventory robots technologies cloud technology-repositories.json ../ && rm -rf wordlists 2>&1
	git clone https://github.com/trickest/resolvers > /dev/null 2>&1
	rm -f LICENSE README.md banner.png resolvers.png 2>/dev/null
	ln -s /usr/share/trickest /usr/share/wordlists > /dev/null 2>&1
	check "Agregando wordlist en /usr/share/wordlist/trickest"
	## WordPress Exploit Framework
	info "Instalando WordPress Exploit Framework"
	cd /
	gem install wpxf > /dev/null 2>&1
	check "Agregando WordPress Exploit Framework"


## Git clone con instalación aparte
	info "Directorios de aplicativos"
	mkdir -p {$PRIVESCLIN_PATH,$PRIVESCWIN_PATH,$OSINT_PATH,$UTILITIES_PATH,$WEB_PATH,$WIFI_PATH,$WORDPRESS_PATH,$AD_PATH,$MOBILE_PATH,$LINUX_PATH,$WINDOWS_PATH,$PIVOTING_PATH,$PHISHING_PATH,$CLOUD_PATH} 2>/dev/null
	check "Creando directorios"
	## GTFOBLookup
	info "Descargando GTFOBLookup"
	cd $LINUX_PATH 2>/dev/null
	git clone --depth 1 https://github.com/nccgroup/GTFOBLookup > /dev/null 2>&1
	cd GTFOBLookup 2>/dev/null
	pip install -r requirements.txt --break-system-packages > /dev/null 2>&1
	python3 gtfoblookup.py update > /dev/null 2>&1
	check "Agregando GTFOBLookup"
	## brutemap
	info "Descargando brutemap"
	cd $WEB_PATH 2>/dev/null
	git clone --depth 1 https://github.com/brutemap-dev/brutemap > /dev/null 2>&1
	cd brutemap 2>/dev/null
	pip install -r requirements.txt --break-system-packages > /dev/null 2>&1
	check "Agregando brutemap"
	## CWFF
	info "Descargando CWFF"
	cd $LINUX_PATH 2>/dev/null
	git clone --depth 1 https://github.com/D4Vinci/CWFF > /dev/null 2>&1
	cd CWFF 2>/dev/null
	pip install -r requirements.txt --break-system-packages > /dev/null 2>&1
	check "Agregando CWFF"
	## Vulnx
	info "Descargando Vulnx"
	cd $WORDPRESS_PATH 2>/dev/null
	git clone --depth 1 https://github.com/anouarbensaad/vulnx > /dev/null 2>&1
	cd vulnx && ./install.sh > /dev/null 2>&1
	check "Agregando Vulnx"
	## Drupwn
	info "Descargando Drupwn"
	cd $WEB_PATH 2>/dev/null
	git clone --depth 1 https://github.com/immunIT/drupwn > /dev/null 2>&1
	cd drupwn && pip install -r requirements.txt --break-system-packages > /dev/null 2>&1
	check "Agregando Drupwn"
	## Typo3Scan
	info "Descargando Typo3Scan"
	cd $WEB_PATH 2>/dev/null
	git clone --depth 1 https://github.com/whoot/Typo3Scan > /dev/null 2>&1
	cd Typo3Scan && pip install -r requirements.txt --break-system-packages > /dev/null 2>&1
	check "Agregando Typo3Scan"
	## Reverse Shell Generator
	info "Descargando Reverse Shell Generator"
	cd $LINUX_PATH 2>/dev/null
	git clone https://github.com/mthbernardes/rsg > /dev/null 2>&1
	cd rsg && ln -s $(pwd)/rsg /usr/local/bin > /dev/null 2>&1
	check "Agregando Reverse Shell Generator"
	## Next Generation version of Enum4Linux
	#info "Descargando Enum4Linux-ng"
	#cd $UTILITIES_PATH 2>/dev/null
	#git clone https://github.com/cddmp/enum4linux-ng.git >/dev/null 2>&1
	#cd enum4linux-ng && pip install -r requirements.txt --break-system-packages >/dev/null 2>&1
	#ln -s $UTILITIES_PATH/enum4linux-ng/enum4linux-ng.py /usr/local/bin/enum4linux-ng  >/dev/null 2>&1
	#check "Agregando Enum4Linux-ng"
	## ASN Lookup Tool and Traceroute Server
	info "Descargando asn"
	cd $WEB_PATH 2>/dev/null
	git clone https://github.com/nitefood/asn >/dev/null 2>&1
	ln -sf $WEB_PATH/asn/asn /usr/local/bin/asn >/dev/null 2>&1
	check "Agregando asn"
	## PyShell
	info "Descargando PyShell"
	cd $WEB_PATH 2>/dev/null
	git clone https://github.com/JoelGMSec/PyShell >/dev/null 2>&1
	cd PyShell ; pip install -r requirements.txt --break-system-packages >/dev/null 2>&1
	check "Agregando PyShell"
	## Ghauri
	info "Descargando ghauri"
	cd $WEB_PATH 2>/dev/null
	git clone https://github.com/r0oth3x49/ghauri >/dev/null 2>&1
	cd ghauri ; pip install -r requirements.txt --break-system-packages >/dev/null 2>&1
	python3 setup.py install >/dev/null 2>&1
	check "Agregando ghauri"
	## WhatWeb-Next-Generation
	#info "Descargando WhatWeb-Next-Generation"
	#cd $WEB_PATH 2>/dev/null
	#git clone https://github.com/urbanadventurer/WhatWeb &>/dev/null
	#cd WhatWeb; bundle install &>/dev/null
	#check "Agregando WhatWeb-Next-Generation"
	## Nuclei-Fuzzing-Templates
	info "Descargando Nuclei-Fuzzing-Templates"
	cd /root/.local/nuclei-templates/ 2>/dev/null
	git clone https://github.com/projectdiscovery/fuzzing-templates > /dev/null 2>&1
	check "Agregando la aplicación Nuclei-Fuzzing-Templates"
	## MobSF
	#info "Descargando MobSF"
	#git clone https://github.com/MobSF/Mobile-Security-Framework-MobSF.git > /dev/null 2>&1
	#cd Mobile-Security-Framework-MobSF; ./setup.sh > /dev/null 2>&1
	#check "Agregando la aplicación MobFS"
	## BloodHound.py
	info "Descargando BloodHound.py"
	cd $AD_PATH 2>/dev/null
	git clone https://github.com/fox-it/BloodHound.py >/dev/null 2>&1
	cd BloodHound.py && python3 setup.py install >/dev/null 2>&1
	check "Agregando BloodHound.py"
	## wwwtree.py
	info "Descargando wwwtree"
	cd /tmp 2>/dev/null
	git clone https://github.com/t3l3machus/wwwtree > /dev/null 2>&1
	cd wwwtree && cp wwwtree.py /usr/local/bin/wwwtree 2>/dev/null
	chmod +x /usr/local/bin/wwwtree 2>/dev/null
	check "Agregando wwwtree"
	## ligolo-ng
	#info "Descargando ligolo-ng"
	#cd $PIVOTING_PATH 2>/dev/null
	#git clone https://github.com/nicocha30/ligolo-ng >/dev/null 2>&1
	#cd ligolo-ng
	#go build -o bin/ligolo-agent cmd/agent/main.go >/dev/null 2>&1
	#go build -o bin/ligolo-proxy cmd/proxy/main.go >/dev/null 2>&1
	#GOOS=windows go build -o bin/ligolo-agent.exe cmd/agent/main.go >/dev/null 2>&1
	#GOOS=windows go build -o bin/ligolo-proxy.exe cmd/proxy/main.go >/dev/null 2>&1
	#mv $PIVOTING_PATH/ligolo-ng/bin/ligolo-proxy /usr/local/bin > /dev/null 2>&1
	#check "Agregando ligolo-ng"
	## wifi_db
	info "Instalando wifi_db"
	cd $WIFI_PATH && git clone https://github.com/r4ulcl/wifi_db > /dev/null 2>&1
	cd wifi_db && pip3 install -r requirements.txt --break-system-packages > /dev/null 2>&1
	check "Agregando wifi_db"
	## UploadBypass
	#info "Instalando Upload_Bypass"
	#cd $WEB_PATH && wget https://github.com/sAjibuu/Upload_Bypass/releases/download/v2.0.8-offical/Upload_Bypass_v2.0.8-offical.zip > /dev/null 2>&1
	#unzip Upload_Bypass_v2.0.8-offical.zip > /dev/null 2>&1
	#rm Upload_Bypass_v2.0.8-offical.zip 2>/dev/null
	#check "Agregando Upload_Bypass"
	## Decodify
	info "Instalando Decodify"
	cd /tmp && git clone https://github.com/s0md3v/Decodify >/dev/null 2>&1
	cd Decodify && chmod +x dcode 2>/dev/null
	mv dcode /usr/local/bin 2>/dev/null
	check "Agregando dcode"
	## KillCast
	info "Instalando KillCast"
	cd /tmp && git clone https://github.com/thewhiteh4t/killcast >/dev/null 2>&1
	cd killcast && chmod +x killcast.py 2>/dev/null
	mv killcast.py /usr/local/bin/killcast 2>/dev/null
	check "Agregando killCast"
	## BashFuscator
	info "Instalando BashFuscator"
	cd /tmp && git clone https://github.com/Bashfuscator/Bashfuscator >/dev/null 2>&1
	cd Bashfuscator && python3 setup.py install --user >/dev/null 2>&1
	mv bashfuscator/bin/bashfuscator /usr/local/bin/bashfuscator 2>/dev/null
	check "Agregando Bashfuscator"
	## Pypykatz
	info "Instalando Pypykatz"
	cd /tmp && git clone https://github.com/skelsec/pypykatz >/dev/null 2>&1
	cd pypykatz && python3 setup.py install >/dev/null 2>&1
	check "Agregando Pypykatz"
	### CrackMapExec
	#info "Instalando CrackMapExec"
	#cd $UTILITIES_PATH 2>/dev/null
	#git clone https://github.com/byt3bl33d3r/CrackMapExec >/dev/null 2>&1
	#cd CrackMapExec && poetry install >/dev/null 2>&1
	#check "Agregando CrackMapExec"
	## ldeep
	info "Instalando ldeep"
	cd /tmp && python3 -m pip install git+https://github.com/franc-pentest/ldeep --break-system-packages >/dev/null 2>&1
	check "Agregando ldeep"

	## Eternalblue-Doublepulsar-Metasploit
	info "Descargando modulo Eternalblue-Doublepulsar para Metasploit"
	cd $LINUX_PATH 2>/dev/null
	git clone https://github.com/ElevenPaths/Eternalblue-Doublepulsar-Metasploit >/dev/null 2>&1
	cd Eternalblue-Doublepulsar-Metasploit 2>/dev/null
	perl -pi -e "s[/root/Eternalblue-Doublepulsar-Metasploit/deps/][/opt/Utilities/Eternalblue-Doublepulsar-Metasploit/deps/]g" eternalblue_doublepulsar.rb
	cp eternalblue_doublepulsar.rb /usr/share/metasploit-framework/modules/exploits/windows/smb > /dev/null 2>&1
	mkdir -p /root/.wine/drive_c/ > /dev/null 2>&1
	check "Agregando modulo Eternalblue-Doublepulsar en Metasploit"



## Descarga usando wget
	## psPY
	info "Descargando pspy"
	cd $PRIVESCLIN_PATH 2>/dev/null
	mkdir pspy > /dev/null 2>&1
	cd pspy 2>/dev/null
	wget https://github.com/DominicBreuker/pspy/releases/latest/download/pspy32 > /dev/null 2>&1
	check "Agregando pspy32"
	wget https://github.com/DominicBreuker/pspy/releases/latest/download/pspy64 > /dev/null 2>&1
	check "Agregando pspy64"
	## Unix-Privesc-Check-PentestMonkey
	info "Descargando unix-privesc-check"
	cd $PRIVESCLIN_PATH 2>/dev/null
	wget http://pentestmonkey.net/tools/unix-privesc-check/unix-privesc-check-1.4.tar.gz > /dev/null 2>&1
	tar -xzf unix-privesc-check-1.4.tar.gz && rm unix-privesc-check-1.4.tar.gz > /dev/null 2>&1
	check "Agregando unix-privesc-check"
	## Pandoc
	info "Descargando pandoc"
	wget "https://github.com/jgm/pandoc/releases/download/2.19.2/pandoc-2.19.2-1-amd64.deb" -O /tmp/pandoc-2.19.2-1-amd64.deb > /dev/null 2>&1
	dpkg -i /tmp/pandoc-2.19.2-1-amd64.deb > /dev/null 2>&1
	check "Agregando pandoc"
	## Eisvogel
	info "Descargando Eisvogel"
	cd /tmp && wget "https://github.com/Wandmalfarbe/pandoc-latex-template/releases/download/v2.1.0/Eisvogel-2.1.0.zip" > /dev/null 2>&1
	echo -e "A" | unzip Eisvogel-2.1.0.zip > /dev/null 2>&1
	mkdir -p /root/.local/share/pandoc/templates > /dev/null 2>&1
	check "Creando directorio Eisvogel"
	mv /tmp/eisvogel.latex /root/.local/share/pandoc/templates > /dev/null 2>&1
	check "Agregando Eisvogel"
	## duf
	info "Descargando duf"
	duf_version=$(curl -IkLs -o /dev/null -w %{url_effective}  https://github.com/muesli/duf/releases/latest|grep -o "[^/]*$"| sed "s/v//g")
	wget "https://github.com/muesli/duf/releases/download/v$duf_version/duf_$duf_version"_linux_amd64.deb -O "/tmp/duf_$duf_version"_linux_amd64.deb > /dev/null 2>&1
	dpkg -i /tmp/duf_0.8.1_linux_amd64.deb > /dev/null 2>&1
	check "Agregando duf v$duf_version"
	## md2pdf
	info "Descargando md2pdf"
	cd /tmp && wget https://raw.githubusercontent.com/m4lal0/md2pdf/main/md2pdf.sh > /dev/null 2>&1
	mv /tmp/md2pdf.sh /usr/local/bin/md2pdf && chmod +x /usr/local/bin/md2pdf > /dev/null 2>&1
	check "Agregando md2pdf"
	## RPCRecon
	info "Descargando RPCRecon"
	cd /tmp && wget https://raw.githubusercontent.com/m4lal0/RPCrecon/main/rpcrecon.sh -O /tmp/rpcrecon > /dev/null 2>&1
	chmod +x /tmp/rpcrecon && mv /tmp/rpcrecon /usr/local/bin/rpcrecon > /dev/null 2>&1
	check "Agregando RPCRecon"
	## RustScan
	info "Descargando RustScan"
	rustscan_version=$(curl -IkLs -o /dev/null -w %{url_effective}  https://github.com/RustScan/RustScan/releases/latest|grep -o "[^/]*$"| sed "s/v//g")
	wget https://github.com/bee-san/RustScan/releases/download/$rustscan_version/rustscan.deb.zip -O /tmp/rustscan.deb.zip > /dev/null 2>&1
	cd /tmp && unzip rustscan.deb.zip > /dev/null 2>&1
	dpkg -i /tmp/rustscan_$rustscan_version-1_amd64.deb > /dev/null 2>&1
	check "Agregando RustScan v$rustscan_version"
	## tempomail
	info "Descargando tempomail"
	cd /tmp/ 2>/dev/null
	wget https://github.com/kavishgr/tempomail/releases/latest/download/linux-amd64-tempomail.tgz > /dev/null 2>&1
	tar -xf linux-amd64-tempomail.tgz > /dev/null 2>&1
	mv tempomail /usr/local/bin/ > /dev/null 2>&1
	check "Agregando tempomail"
	## ABE (Android-Backup-Extractor)
	info "Descargando Android-Backup-Extractor"
	mkdir $MOBILE_PATH/Android-Backup-Extractor && wget "https://github.com/nelenkov/android-backup-extractor/releases/download/master-20221109063121-8fdfc5e/abe.jar" -O $MOBILE_PATH/Android-Backup-Extractor/abe.jar > /dev/null 2>&1
	check "Agregando Android-Backup-Extractor"
	## Venom
	info "Descargando venom"
	venom_version=$(curl -IkLs -o /dev/null -w %{url_effective}  https://github.com/ovh/venom/releases/latest|grep -o "[^/]*$"| sed "s/v//g")
	curl https://github.com/ovh/venom/releases/download/v$venom_version/venom.linux-amd64 -L -o /usr/local/bin/venom > /dev/null 2>&1
	chmod +x /usr/local/bin/venom
	check "Agregando venom v$venom_version"
	## CORS
	info "Descargando CORS"
	mkdir $WEB_PATH/CORS &&	wget https://raw.githubusercontent.com/gwen001/pentest-tools/master/cors.py -O $WEB_PATH/CORS/cors.py > /dev/null 2>&1
	check "Agregando cors.py"
	## Rustcat
	info "Descargando rustcat"
	rustcat_version=$(curl -IkLs -o /dev/null -w %{url_effective}  https://github.com/robiot/rustcat/releases/latest|grep -o "[^/]*$"| sed "s/v//g")
	wget "https://github.com/robiot/rustcat/releases/download/v$rustcat_version/rcat-v$rustcat_version-linux-x86_64.deb" -O /tmp/rcat-v$rustcat_version-linux-x86_64.deb > /dev/null 2>&1
	cd /tmp && sudo apt install ./rcat-v$rustcat_version-linux-x86_64.deb  > /dev/null 2>&1
	if [ $? -ne 0 ]; then
		apt --fix-broken install -y > /dev/null 2>&1
		sudo apt install ./rcat-v$rustcat_version-linux-x86_64.deb > /dev/null 2>&1
	fi
	check "Agregando rustcat v$rustcat_version"
	## BloodHound
	info "Descargando BloodHound"
	cd $AD_PATH 2>/dev/null
	wget https://github.com/BloodHoundAD/BloodHound/releases/download/4.0.3/BloodHound-linux-x64.zip > /dev/null 2>&1
	unzip BloodHound-linux-x64.zip > /dev/null 2>&1
	rm BloodHound-linux-x64.zip > /dev/null 2>&1
	mv BloodHound-linux-x64 BloodHound 2>/dev/null
	check "Agregando BloodHound v4.0.3"
	## Kill-Port
	info "Descargando KillPort"
	cd /tmp && wget https://github.com/jkfran/killport/releases/latest/download/killport-x86_64-linux-gnu.tar.gz > /dev/null 2>&1
	tar -xzf killport-x86_64-linux-gnu.tar.gz > /dev/null 2>&1
	mv killport /usr/local/bin
	check "Agregando KillPort"
	## PHP_Reverse_Shell
	info "Descargando php_reverse_shell.php"
	wget https://raw.githubusercontent.com/ivan-sincek/php-reverse-shell/master/src/reverse/php_reverse_shell.php -O /usr/share/webshells/php/php_reverse_shell.php > /dev/null 2>&1
	check "Agregando php_reverse_shell.php"
	## Rubeus.exe
	info "Descargando Rubeus.exe"
	cd $AD_PATH && mkdir Rubeus 2>/dev/null
	#wget https://github.com/r3motecontrol/Ghostpack-CompiledBinaries/raw/master/Rubeus.exe -O $AD_PATH/Rubeus/Rubeus.exe > /dev/null 2>&1
	wget https://github.com/r3motecontrol/Ghostpack-CompiledBinaries/raw/refs/heads/master/dotnet%20v4.8.1%20compiled%20binaries/Rubeus.exe -O $AD_PATH/Rubeus/Rubeus.exe > /dev/null 2>&1
	check "Agregando Rubeus.exe"
	## SharpHound.ps1
	info "Descargando SharpHound.ps1"
	cd $AD_PATH && mkdir SharpHound 2>/dev/null
	wget https://raw.githubusercontent.com/puckiestyle/powershell/master/SharpHound.ps1 -O $AD_PATH/SharpHound/SharpHound.ps1 > /dev/null 2>&1
	check "Agregando SharpHound.ps1"
	## SharpHound.exe
	info "Descargando SharpHound.exe"
	wget https://github.com/BloodHoundAD/BloodHound/raw/refs/heads/master/Collectors/SharpHound.exe -O $AD_PATH/SharpHound/SharpHound.exe > /dev/null 2>&1
	check "Agregando SharpHound.exe"
	## SharpView.exe
	info "Descargando SharpView.exe"
	cd $AD_PATH && mkdir SharpView 2>/dev/null
	wget https://github.com/tevora-threat/SharpView/raw/refs/heads/master/Compiled/SharpView.exe -O $AD_PATH/SharpView/SharpView.exe > /dev/null 2>&1
	check "Agregando SharpView.exe"
	## SharpUp.exe
	info "Descargando SharpUp.exe"
	cd $PRIVESCWIN_PATH && mkdir SharpUp 2>/dev/null
	#wget https://github.com/r3motecontrol/Ghostpack-CompiledBinaries/raw/master/SharpUp.exe -O $PRIVESCWIN_PATH/SharpUp/SharpUp.exe > /dev/null 2>&1
	wget https://github.com/r3motecontrol/Ghostpack-CompiledBinaries/raw/refs/heads/master/dotnet%20v4.8.1%20compiled%20binaries/SharpUp.exe -O $PRIVESCWIN_PATH/SharpUp/SharpUp.exe > /dev/null 2>&1
	check "Agregando SharpUp.exe"
	## SafetyKatz.exe
	info "Descargando SafetyKatz.exe"
	cd $AD_PATH && mkdir SafetyKatz 2>/dev/null
	#wget https://github.com/r3motecontrol/Ghostpack-CompiledBinaries/raw/master/SafetyKatz.exe -O $AD_PATH/SafetyKatz/SafetyKatz.exe > /dev/null 2>&1
	wget https://github.com/r3motecontrol/Ghostpack-CompiledBinaries/raw/refs/heads/master/dotnet%20v4.8.1%20compiled%20binaries/SafetyKatz.exe -O $AD_PATH/SafetyKatz/SafetyKatz.exe > /dev/null 2>&1
	check "Agregando SafetyKatz.exe"
	## JuicyPotatoNG
	info "Descargando JuicyPotatoNG"
	cd $PRIVESCWIN_PATH && mkdir JuicyPotato 2>/dev/null
	wget https://github.com/antonioCoco/JuicyPotatoNG/releases/latest/download/JuicyPotatoNG.zip -O $PRIVESCWIN_PATH/JuicyPotato/JuicyPotatoNG.zip > /dev/null 2>&1
	cd $PRIVESCWIN_PATH/JuicyPotato/ && unzip JuicyPotatoNG.zip > /dev/null 2>&1
	rm -f $PRIVESCWIN_PATH/JuicyPotato/JuicyPotatoNG.zip > /dev/null 2>&1
	check "Agregando JuicyPotatoNG"
	## JuicyPotato.exe
	info "Descargando JuicyPotato.exe"
	wget https://github.com/ohpe/juicy-potato/releases/latest/download/JuicyPotato.exe -O $PRIVESCWIN_PATH/JuicyPotato/JuicyPotato.exe > /dev/null 2>&1
	check "Agregando JuicyPotato.exe"
	## JuicyPotato-x86.exe
	info "Descargando JuicyPotato.exe"
	wget https://github.com/kraloveckey/ghostpack-binaries/raw/refs/heads/main/Potatos/JuicyPotato-x86-v0.1.exe -O $PRIVESCWIN_PATH/JuicyPotato/JuicyPotato-x86-v0.1.exe > /dev/null 2>&1
	check "Agregando JuicyPotato-x86.exe"
	## Churrasco.exe
	info "Descargando churrasco.exe"
	cd $PRIVESCWIN_PATH && mkdir churrasco 2>/dev/null
	wget https://github.com/Re4son/Churrasco/raw/master/churrasco.exe -O $PRIVESCWIN_PATH/churrasco/churrasco.exe > /dev/null 2>&1
	check "Agregando churrasco.exe"
	## PrintSpoofer.exe
	info "Descargando PrintSpoofer.exe"
	cd $PRIVESCWIN_PATH && mkdir PrintSpoofer 2>/dev/null
	wget https://github.com/k4sth4/PrintSpoofer/raw/main/PrintSpoofer.exe -O $PRIVESCWIN_PATH/PrintSpoofer/PrintSpoofer.exe > /dev/null 2>&1
	wget https://github.com/itm4n/PrintSpoofer/releases/latest/download/PrintSpoofer64.exe -O $PRIVESCWIN_PATH/PrintSpoofer/PrintSpoofer64.exe > /dev/null 2>&1
	check "Agregando PrintSpoofer.exe"
	## WinPEAS.exe
	info "Descargando winPEAS.exe"
	cd $PRIVESCWIN_PATH && mkdir winPEAS-common-binaries 2>/dev/null
	wget https://github.com/carlospolop/PEASS-ng/releases/latest/download/winPEASx64.exe -O $PRIVESCWIN_PATH/winPEAS-common-binaries/winPEASx64.exe > /dev/null 2>&1
	check "Agregando winPEASx64.exe"
	wget https://github.com/carlospolop/PEASS-ng/releases/latest/download/winPEASx86.exe -O $PRIVESCWIN_PATH/winPEAS-common-binaries/winPEASx86.exe > /dev/null 2>&1
	check "Agregando winPEASx86.exe"
	wget https://github.com/carlospolop/PEASS-ng/releases/latest/download/winPEASany.exe -O $PRIVESCWIN_PATH/winPEAS-common-binaries/winPEASany.exe > /dev/null 2>&1
	check "Agregando winPEASany.exe"
	## LinPEAS
	info "Descargando LinPEAS"
	cd $PRIVESCLIN_PATH && mkdir linpeas 2>/dev/null
	wget https://github.com/carlospolop/PEASS-ng/releases/latest/download/linpeas.sh -O $PRIVESCLIN_PATH/linpeas/linpeas.sh > /dev/null 2>&1
	check "Agregando LinPEAS"
	## Arachni
	info "Descargando Arachni"
	cd $WEB_PATH 2>/dev/null
	wget https://github.com/Arachni/arachni/releases/download/v1.6.1.3/arachni-1.6.1.3-0.6.1.1-linux-x86_64.tar.gz > /dev/null 2>&1
	tar -xzf arachni-1.6.1.3-0.6.1.1-linux-x86_64.tar.gz > /dev/null 2>&1
	rm -rf arachni-1.6.1.3-0.6.1.1-linux-x86_64.tar.gz > /dev/null 2>&1
	check "Agregando Arachni"
	## CAPA
	info "Descargando CAPA"
	capa_version=$(curl -IkLs -o /dev/null -w %{url_effective} https://github.com/mandiant/capa/releases/latest|grep -o "[^/]*$"| sed "s/v//g")
	wget https://github.com/mandiant/capa/releases/download/v$capa_version/capa-v$capa_version-linux.zip -O /tmp/capa-v$capa_version-linux.zip > /dev/null 2>&1
	cd /tmp && unzip /tmp/capa-v$capa_version-linux.zip > /dev/null 2>&1
	mv /tmp/capa /usr/local/bin
	check "Agregando CAPA v$capa_version"
	## IPATool
	info "Descargando IPAtool"
	ipatool_version=$(curl -IkLs -o /dev/null -w %{url_effective} https://github.com/majd/ipatool/releases/latest|grep -o "[^/]*$"| sed "s/v//g")
	wget https://github.com/majd/ipatool/releases/download/v$ipatool_version/ipatool-$ipatool_version-linux-amd64.tar.gz -O /tmp/ipatool-$ipatool_version-linux-amd64.tar.gz > /dev/null 2>&1
	cd /tmp && tar -xzf /tmp/ipatool-$ipatool_version-linux-amd64.tar.gz > /dev/null 2>&1
	chmod +x /tmp/bin/ipatool-$ipatool_version-linux-amd64
	mv /tmp/bin/ipatool-$ipatool_version-linux-amd64 /usr/local/bin/ipatool
	check "Agregando IPAtool v$ipatool_version"
	## Govenom
	info "Descargando Govenom"
	wget https://github.com/arch3rPro/Govenom/releases/download/pre/linux_amd64.tar.gz -O /tmp/linux_amd64.tar.gz > /dev/null 2>&1
	cd /tmp && tar -xzf /tmp/linux_amd64.tar.gz > /dev/null 2>&1
	mv /tmp/Govenom /usr/local/bin
	check "Instalando Govenom"
	## NetExec
	info "Instalando NetExec"
	cd $UTILITIES_PATH; mkdir NetExec 2>/dev/null
	cd NetExec && wget https://github.com/Pennyw0rth/NetExec/releases/download/v1.3.0/nxc-ubuntu-latest.zip >/dev/null 2>&1
	unzip nxc-ubuntu-latest.zip >/dev/null 2>&1
	rm -rf nxc-ubuntu-latest.zip >/dev/null 2>&1
	chmod +x nxc; mv nxc netexec && cp netexec /usr/local/bin/netexec >/dev/null 2>&1
	check "Agregando NetExec"
	## RunasCs
	info "Descargando RunasCs"
	cd $PRIVESCWIN_PATH && mkdir RunasCs 2>/dev/null
	runascs_version=$(curl -IkLs -o /dev/null -w %{url_effective} https://github.com/antonioCoco/RunasCs/releases/latest|grep -o "[^/]*$"| sed "s/v//g")
	wget https://github.com/antonioCoco/RunasCs/releases/download/v$runascs_version/RunasCs.zip -O $PRIVESCWIN_PATH/RunasCs/RunasCs.zip > /dev/null 2>&1
	cd $PRIVESCWIN_PATH/RunasCs && unzip RunasCs.zip > /dev/null 2>&1
	rm -f $PRIVESCWIN_PATH/RunasCs/RunasCs.zip > /dev/null 2>&1
	check "Agregando RunasCs v$runascs_version"
	## Seatbelt.exe
	info "Descargando Seatbelt.exe"
	cd $PRIVESCWIN_PATH && mkdir Seatbelt 2>/dev/null
	#wget https://github.com/r3motecontrol/Ghostpack-CompiledBinaries/raw/master/Seatbelt.exe -O $PRIVESCWIN_PATH/Seatbelt/Seatbelt.exe > /dev/null 2>&1
	wget https://github.com/r3motecontrol/Ghostpack-CompiledBinaries/raw/refs/heads/master/dotnet%20v4.8.1%20compiled%20binaries/Seatbelt.exe -O $PRIVESCWIN_PATH/Seatbelt/Seatbelt.exe > /dev/null 2>&1
	check "Agregando Seatbelt.exe"
	## x8
	info "Descargando x8"
	x8_version=$(curl -IkLs -o /dev/null -w %{url_effective} https://github.com/Sh1Yo/x8/releases/latest|grep -o "[^/]*$"| sed "s/v//g")
	cd /tmp && wget https://github.com/Sh1Yo/x8/releases/download/v$x8_version/x86_64-linux-x8.gz > /dev/null 2>&1
	gzip -d x86_64-linux-x8.gz 2>/dev/null
	mv x86_64-linux-x8 x8 && mv x8 /usr/local/bin/ 2>/dev/null
	chmod +x /usr/local/bin/x8 2>/dev/null
	check "Agregando x8 v$x8_version"
	## LaZagne.exe
	info "Descargando LaZagne.exe"
	cd $WINDOWS_PATH && mkdir LaZagne 2>/dev/null
	lazagne_version=$(curl -IkLs -o /dev/null -w %{url_effective} https://github.com/AlessandroZ/LaZagne/releases/latest|grep -o "[^/]*$"| sed "s/v//g")
	wget https://github.com/AlessandroZ/LaZagne/releases/download/v$lazagne_version/LaZagne.exe -O $WINDOWS_PATH/LaZagne/LaZagne.exe > /dev/null 2>&1
	check "Agregando LaZagne.exe v$lazagne_version"
	## Pretender
	info "Descargando Pretender"
	cd /tmp && wget https://github.com/RedTeamPentesting/pretender/releases/download/v1.2.0/pretender_Linux_x86_64.tar.gz > /dev/null 2>&1
	tar -xzf pretender_Linux_x86_64.tar.gz > /dev/null 2>&1
	mv /tmp/pretender /usr/local/bin
	check "Instalando Pretender"
	## Snaffler
	info "Descargando Snaffler"
	cd $AD_PATH && mkdir Snaffler 2>/dev/null
	snaffler_version=$(curl -IkLs -o /dev/null -w %{url_effective} https://github.com/SnaffCon/Snaffler/releases/latest|grep -o "[^/]*$"| sed "s/v//g")
	wget https://github.com/SnaffCon/Snaffler/releases/download/$snaffler_version/Snaffler.exe -O $AD_PATH/Snaffler/Snaffler.exe > /dev/null 2>&1
	check "Agregando Snaffler v$snaffler_version"
	## Kerbrute.exe
	info "Descargando Kerbrute.exe"
	cd $AD_PATH && mkdir Kerbrute 2>/dev/null
	kerbrute_version=$(curl -IkLs -o /dev/null -w %{url_effective} https://github.com/ropnop/kerbrute/releases/latest|grep -o "[^/]*$"| sed "s/v//g")
	wget https://github.com/ropnop/kerbrute/releases/download/v$kerbrute_version/kerbrute_windows_386.exe -O $AD_PATH/Kerbrute/kerbrute_windows_386.exe > /dev/null 2>&1
	check "Agregando kerbrute_windows_386.exe v$kerbrute_version"
	wget https://github.com/ropnop/kerbrute/releases/download/v$kerbrute_version/kerbrute_windows_amd64.exe -O $AD_PATH/Kerbrute/kerbrute_windows_amd64.exe > /dev/null 2>&1
	check "Agregando kerbrute_windows_amd64.exe v$kerbrute_version"
	## ILSpy
	info "Descargando ILSpy"
	cd $WINDOWS_PATH && mkdir ILSpy 2>/dev/null
	cd /tmp && wget https://github.com/icsharpcode/AvaloniaILSpy/releases/download/v7.2-rc/Linux.x64.Release.zip > /dev/null 2>&1
	unzip Linux.x64.Release.zip > /dev/null 2>&1
	unzip ILSpy-linux-x64-Release.zip > /dev/null 2>&1
	mv /tmp/artifacts $WINDOWS_PATH/ILSpy 2>/dev/null
	check "Agregando ILSpy"
	## PowerUpSQL.ps1
	info "Descargando PowerUpSQL.ps1"
	cd $AD_PATH && mkdir PowerUpSQL 2>/dev/null
	wget https://raw.githubusercontent.com/NetSPI/PowerUpSQL/refs/heads/master/PowerUpSQL.ps1 -O $AD_PATH/PowerUpSQL/PowerUpSQL.ps1 > /dev/null 2>&1
	check "Agregando PowerUpSQL.ps1"
	## Group3r.exe
	info "Descargando Group3r.exe"
	cd $AD_PATH && mkdir Group3r 2>/dev/null
	group3r_version=$(curl -IkLs -o /dev/null -w %{url_effective} https://github.com/Group3r/Group3r/releases/latest|grep -o "[^/]*$"| sed "s/v//g")
	wget https://github.com/Group3r/Group3r/releases/download/$group3r_version/Group3r.exe -O $AD_PATH/Group3r/Group3r.exe > /dev/null 2>&1
	check "Agregando Group3r.exe v$group3r_version"
	## PingCastle.exe
	info "Descargando PingCastle.exe"
	cd $AD_PATH && mkdir PingCastle 2>/dev/null
	pingcastle_version=$(curl -IkLs -o /dev/null -w %{url_effective} https://github.com/netwrix/pingcastle/releases/latest|grep -o "[^/]*$"| sed "s/v//g")
	wget https://github.com/netwrix/pingcastle/releases/download/v$pingcastle_version/PingCastle_$pingcastle_version.zip -O $AD_PATH/PingCastle/PingCastle_$pingcastle_version.zip > /dev/null 2>&1
	cd PingCastle && unzip PingCastle_$pingcastle_version.zip > /dev/null 2>&1
	rm -rf PingCastle_$pingcastle_version.zip > /dev/null 2>&1
	check "Agregando PingCastle.exe v$pingcastle_version"
	## plink.exe
	info "Descargando plink.exe"
	cd $PIVOTING_PATH && mkdir plink 2>/dev/null
	wget https://s3.amazonaws.com/plink1-assets/plink_win32_20241022.zip -O /tmp/plink_win32_20241022.zip > /dev/null 2>&1
	cd /tmp && unzip -o plink_win32_20241022.zip > /dev/null 2>&1
	mv /tmp/plink.exe $PIVOTING_PATH/plink/plink-32.exe 2>/dev/null
	check "Agregando plink.exe de 32 bits"
	wget https://s3.amazonaws.com/plink1-assets/plink_win64_20241022.zip -O /tmp/plink_win64_20241022.zip > /dev/null 2>&1
	cd /tmp && unzip -o plink_win64_20241022.zip > /dev/null 2>&1
	mv /tmp/plink.exe $PIVOTING_PATH/plink/plink-64.exe 2>/dev/null
	check "Agregando plink.exe de 64 bits"
	## Find-WMILocalAdminAccess.ps1
	info "Descargando Find-WMILocalAdminAccess.ps1"
	cd $AD_PATH && mkdir Find-WMILocalAdminAccess 2>/dev/null
	wget https://raw.githubusercontent.com/admin0987654321/admin1/refs/heads/master/Find-WMILocalAdminAccess.ps1 -O $AD_PATH/Find-WMILocalAdminAccess/Find-WMILocalAdminAccess.ps1 > /dev/null 2>&1
	check "Agregando Find-WMILocalAdminAccess.ps1"
	## SharpChisel.exe
	info "Descargando SharpChisel.exe"
	cd $AD_PATH && mkdir SharpChisel 2>/dev/null
	sharpchisel_version=$(curl -IkLs -o /dev/null -w %{url_effective} https://github.com/shantanu561993/SharpChisel/releases/latest|grep -o "[^/]*$"| sed "s/v//g")
	wget https://github.com/shantanu561993/SharpChisel/releases/download/v$sharpchisel_version/SharpChisel.exe -O $AD_PATH/SharpChisel/SharpChisel.exe > /dev/null 2>&1
	check "Agregando SharpChisel.exe v$sharpchisel_version"
	## beRoot.exe
	info "Descargando beRoot.exe"
	cd $PRIVESCWIN_PATH && mkdir beRoot 2>/dev/null
	beRoot_version=$(curl -IkLs -o /dev/null -w %{url_effective} https://github.com/AlessandroZ/BeRoot/releases/latest|grep -o "[^/]*$"| sed "s/v//g")
	wget https://github.com/AlessandroZ/BeRoot/releases/download/$beRoot_version/beRoot.zip -O $PRIVESCWIN_PATH/beRoot/beRoot.zip > /dev/null 2>&1
	cd beRoot && unzip beRoot.zip > /dev/null 2>&1
	rm -rf beRoot.zip > /dev/null 2>&1
	check "Agregando beRoot.exe v$beRoot_version"
	## Ligolo-ng
	info "Descargando ligolo-ng-agent"
	cd $PIVOTING_PATH && mkdir ligolo-ng && cd ligolo-ng 2>/dev/null
	ligolo_version=$(curl -IkLs -o /dev/null -w %{url_effective} https://github.com/nicocha30/ligolo-ng/releases/latest|grep -o "[^/]*$"| sed "s/v//g")
	wget https://github.com/nicocha30/ligolo-ng/releases/download/v"$ligolo_version"/ligolo-ng_agent_"$ligolo_version"_linux_amd64.tar.gz -O $PIVOTING_PATH/ligolo-ng/ligolo-ng_agent_"$ligolo_version"_linux_amd64.tar.gz >/dev/null 2>&1
	tar -xzf ligolo-ng_agent_"$ligolo_version"_linux_amd64.tar.gz >/dev/null 2>&1
	rm -rf LICENSE README.md ligolo-ng_agent_"$ligolo_version"_linux_amd64.tar.gz 2>/dev/null
	mv agent ligolo-agent 2>/dev/null
	check "Agregando ligolo-ng-agent v$ligolo_version"
	info "Descargando ligolo-ng-proxy"
	wget https://github.com/nicocha30/ligolo-ng/releases/download/v"$ligolo_version"/ligolo-ng_proxy_"$ligolo_version"_linux_amd64.tar.gz -O $PIVOTING_PATH/ligolo-ng/ligolo-ng_proxy_"$ligolo_version"_linux_amd64.tar.gz >/dev/null 2>&1
	tar -xzf ligolo-ng_proxy_"$ligolo_version"_linux_amd64.tar.gz >/dev/null 2>&1
	rm -rf LICENSE README.md ligolo-ng_proxy_"$ligolo_version"_linux_amd64.tar.gz 2>/dev/null
	mv proxy ligolo-proxy && cp ligolo-proxy /usr/local/bin 2>/dev/null
	check "Agregando ligolo-ng-proxy v$ligolo_version"
	info "Descargando ligolo-ng-agent.exe"
	mkdir Windows && cd Windows 2>/dev/null
	wget https://github.com/nicocha30/ligolo-ng/releases/download/v"$ligolo_version"/ligolo-ng_agent_"$ligolo_version"_windows_amd64.zip -O $PIVOTING_PATH/ligolo-ng/Windows/ligolo-ng_agent_"$ligolo_version"_windows_amd64.zip >/dev/null 2>&1
	unzip ligolo-ng_agent_"$ligolo_version"_windows_amd64.zip >/dev/null 2>&1
	rm -rf LICENSE README.md ligolo-ng_agent_"$ligolo_version"_windows_amd64.zip 2>/dev/null
	mv agent.exe ligolo-agent.exe 2>/dev/null
	check "Agregando ligolo-ng-agent.exe v$ligolo_version"
	info "Descargando ligolo-ng-proxy.exe"
	wget https://github.com/nicocha30/ligolo-ng/releases/download/v"$ligolo_version"/ligolo-ng_proxy_"$ligolo_version"_windows_amd64.zip -O $PIVOTING_PATH/ligolo-ng/Windows/ligolo-ng_proxy_"$ligolo_version"_windows_amd64.zip >/dev/null 2>&1
	unzip ligolo-ng_proxy_"$ligolo_version"_windows_amd64.zip >/dev/null 2>&1
	rm -rf LICENSE README.md ligolo-ng_proxy_"$ligolo_version"_windows_amd64.zip 2>/dev/null
	mv proxy.exe ligolo-proxy.exe 2>/dev/null
	check "Agregando ligolo-ng-proxy.exe v$ligolo_version"
	## InvokeADCheck
	info "Instalando InvokeADCheck"
	cd $AD_PATH && mkdir InvokeADCheck 2>/dev/null
	cd InvokeADCheck && wget https://github.com/sensepost/InvokeADCheck/raw/refs/heads/main/release/InvokeADCheck-current.zip >/dev/null 2>&1
	unzip InvokeADCheck-current.zip >/dev/null 2>&1
	rm InvokeADCheck-current.zip 2>/dev/null
	check "Agregando InvokeADCheck"
	## Caido
	info "Descargando Caido"
	caido_version=$(curl -IkLs -o /dev/null -w %{url_effective} https://github.com/caido/caido/releases/latest|grep -o "[^/]*$"| sed "s/v//g")
	wget https://caido.download/releases/v"$caido_version"/caido-desktop-v"$caido_version"-linux-x86_64.deb -O /tmp/caido-desktop-v"$caido_version"-linux-x86_64.deb >/dev/null 2>&1
	dpkg -i /tmp/caido-desktop-v"$caido_version"-linux-x86_64.deb > /dev/null 2>&1
	check "Agregando Caido v$caido_version"
	## Frida Server
	info "Descargando Frida Server"
	cd $MOBILE_PATH && mkdir frida-server-binaries 2>/dev/null
	frida_version=$(curl -IkLs -o /dev/null -w %{url_effective} https://github.com/frida/frida/releases/latest|grep -o "[^/]*$"| sed "s/v//g")
	wget https://github.com/frida/frida/releases/download/$frida_version/frida-server-"$frida_version"-android-x86.xz -O $MOBILE_PATH/frida-server-binaries/frida-server-"$frida_version"-android-x86.xz >/dev/null 2>&1
	cd frida-server-binaries && xz -d frida-server-"$frida_version"-android-x86.xz > /dev/null 2>&1
	check "Agregando frida-server-androidx86-v$frida_version"
	wget https://github.com/frida/frida/releases/download/$frida_version/frida-server-"$frida_version"-android-x86_64.xz -O $MOBILE_PATH/frida-server-binaries/frida-server-"$frida_version"-android-x86_64.xz >/dev/null 2>&1
	xz -d frida-server-"$frida_version"-android-x86_64.xz > /dev/null 2>&1
	check "Agregando frida-server-androidx86_64-v$frida_version"
	## goSecretsDump
	info "Descargando goSecretsDump"
	gosecretsdump_version=$(curl -IkLs -o /dev/null -w %{url_effective} https://github.com/C-Sto/gosecretsdump/releases/latest|grep -o "[^/]*$"| sed "s/v//g")
	wget https://github.com/C-Sto/gosecretsdump/releases/download/v"$gosecretsdump_version"/gosecretsdump_linux_v"$gosecretsdump_version" -O /tmp/gosecretsdump_linux_v"$gosecretsdump_version" >/dev/null 2>&1
	chmod +x /tmp/gosecretsdump_linux_v"$gosecretsdump_version" && mv /tmp/gosecretsdump_linux_v"$gosecretsdump_version" /usr/local/bin/gosecretsdump 2>/dev/null
	check "Agregando gosecretsdump v$gosecretsdump_version"
	## windapSearch
	info "Descargando windapSearch"
	windapsearch_version=$(curl -IkLs -o /dev/null -w %{url_effective} https://github.com/ropnop/go-windapsearch/releases/latest|grep -o "[^/]*$"| sed "s/v//g")
	wget https://github.com/ropnop/go-windapsearch/releases/download/v"$windapsearch_version"/windapsearch-linux-amd64 -O /tmp/windapsearch-linux-amd64 >/dev/null 2>&1
	chmod +x /tmp/windapsearch-linux-amd64 && mv /tmp/windapsearch-linux-amd64 /usr/local/bin/windapsearch 2>/dev/null
	check "Agregando windapSearch v$windapsearch_version"
	## GodPotato
	info "Descargando GodPotato.exe"
	cd $PRIVESCWIN_PATH && mkdir GodPotato 2>/dev/null
	godpotato_version=$(curl -IkLs -o /dev/null -w %{url_effective} https://github.com/BeichenDream/GodPotato/releases/latest|grep -o "[^/]*$"| sed "s/v//g")
	wget https://github.com/BeichenDream/GodPotato/releases/download/"$godpotato_version"/GodPotato-NET2.exe -O $PRIVESCWIN_PATH/GodPotato/GodPotato-NET2.exe >/dev/null 2>&1
	check "Agregando GodPotato-NET2.exe $godpotato_version"
	wget https://github.com/BeichenDream/GodPotato/releases/download/"$godpotato_version"/GodPotato-NET35.exe -O $PRIVESCWIN_PATH/GodPotato/GodPotato-NET35.exe >/dev/null 2>&1
	check "Agregando GodPotato-NET35.exe $godpotato_version"
	wget https://github.com/BeichenDream/GodPotato/releases/download/"$godpotato_version"/GodPotato-NET4.exe -O $PRIVESCWIN_PATH/GodPotato/GodPotato-NET4.exe >/dev/null 2>&1
	check "Agregando GodPotato-NET4.exe $godpotato_version"
	## CloudFlared
	info "Descargando CloudFlared"
	cloudflared_version=$(curl -IkLs -o /dev/null -w %{url_effective} https://github.com/cloudflare/cloudflared/releases/latest|grep -o "[^/]*$"| sed "s/v//g")
	wget https://github.com/cloudflare/cloudflared/releases/download/"$cloudflared_version"/cloudflared-linux-amd64 -O /tmp/cloudflared-linux-amd64 >/dev/null 2>&1
	chmod +x /tmp/cloudflared-linux-amd64 && mv /tmp/cloudflared-linux-amd64 /usr/local/bin/cloudflared 2>/dev/null
	check "Agregando cloudflared v$cloudflared_version"
	## Username_Generator
	info "Descargando username_generator"
	wget https://raw.githubusercontent.com/shroudri/username_generator/refs/heads/main/username_generator.py -O /usr/local/bin/username_generator >/dev/null 2>&1
	chmod +x /usr/local/bin/username_generator 2>/dev/null
	check "Agregando username_generator"
	## ADSearch.exe
	info "Descargando ADSearch.exe"
	cd $AD_PATH && mkdir ADSearch 2>/dev/null
	wget https://github.com/Flangvik/SharpCollection/raw/refs/heads/master/NetFramework_4.7_x64/ADSearch.exe -O $AD_PATH/ADSearch/ADSearch.exe >/dev/null 2>&1
	check "Agregando ADSearch.exe"
	## gitjacker
	info "Descargando gitjacker"
	gitjacker_version=$(curl -IkLs -o /dev/null -w %{url_effective} https://github.com/liamg/gitjacker/releases/latest|grep -o "[^/]*$"| sed "s/v//g")
	wget https://github.com/liamg/gitjacker/releases/download/v$gitjacker_version/gitjacker-linux-amd64 -O /tmp/gitjacker >/dev/null 2>&1
	chmod +x /tmp/gitjacker && mv /tmp/gitjacker /usr/local/bin/gitjacker 2>/dev/null
	check "Agregando gitjacker v$gitjacker_version"
	## grace
	info "Descargando grace"
	wget https://github.com/liamg/grace/releases/download/v0.0.1/grace-linux-amd64 -O /tmp/grace >/dev/null 2>&1
	chmod +x /tmp/grace && mv /tmp/grace /usr/local/bin/grace 2>/dev/null
	check "Agregando grace"
	## PsExec63.exe
	info "Descargando PsExec64.exe"
	wget https://github.com/kraloveckey/ghostpack-binaries/raw/refs/heads/main/PsExec64/PsExec64-v2.2.exe -O /usr/share/windows-resources/binaries/PsExec64.exe >/dev/null 2>&1
	chmod +x /usr/share/windows-resources/binaries/PsExec64.exe 2>/dev/null
	check "Agregando PsExec64.exe en usr/share/windows-resources"
	## SharpWSUS.exe
	info "Descargando SharpWSUS.exe"
	cd $PRIVESCWIN_PATH && mkdir SharpWSUS 2>/dev/null
	wget https://github.com/kraloveckey/ghostpack-binaries/raw/refs/heads/main/SharpWSUS/SharpWSUS.exe -O $PRIVESCWIN_PATH/SharpWSUS/SharpWSUS.exe > /dev/null 2>&1
	check "Agregando SharpWSUS.exe"
	## ADReaper
	info "Descargando ADReaper & ADReaper.exe"
	cd $AD_PATH && mkdir ADReaper 2>/dev/null
	wget https://github.com/m0n1x90/ADReaper/releases/download/ADReaperv1.1/ADReaper -O $AD_PATH/ADReaper/ADReaper > /dev/null 2>&1
	chmod +x $AD_PATH/ADReaper/ADReaper 2>/dev/null
	check "Agregando ADReaper v1.1 para Linux"
	wget https://github.com/m0n1x90/ADReaper/releases/download/ADReaperv1.1/ADReaper.exe -O $AD_PATH/ADReaper/ADReaper.exe > /dev/null 2>&1
	check "Agregando ADReaper v1.1 para Windows"
	## ConPtyShell.ps1
	info "Descargando ConPtyShell"
	cd $WINDOWS_PATH && mkdir ConPtyShell 2>/dev/null
	wget https://raw.githubusercontent.com/antonioCoco/ConPtyShell/master/Invoke-ConPtyShell.ps1 -O $WINDOWS_PATH/ConPtyShell/Invoke-ConPtyShell.ps1 > /dev/null 2>&1
	check "Agregando Invoke-ConPtyShell.ps1"
	wget https://github.com/antonioCoco/ConPtyShell/releases/download/1.5/ConPtyShell.zip -O $WINDOWS_PATH/ConPtyShell/ConPtyShell.zip > /dev/null 2>&1
	cd ConPtyShell && unzip ConPtyShell.zip > /dev/null 2>&1
	rm -rf ConPtyShell.zip > /dev/null 2>&1
	check "Agregando ConPtyShell.exe"
	## DirDar
	info "Descargando DirDar"
	cd /tmp && wget https://github.com/M4DM0e/DirDar/releases/download/v1.0.0/DirDarV1.0-linux64.zip > /dev/null 2>&1
	unzip DirDarV1.0-linux64.zip > /dev/null 2>&1
	mv /tmp/releases/dirdar /usr/local/bin/dirdar 2> /dev/null
	check "Agregando DirDar"
	## checkDMARC
	info "Descargando checkDMARC"
	wget https://raw.githubusercontent.com/m4lal0/checkDMARC/refs/heads/main/checkDMARC.sh -O /tmp/checkDMARC.sh > /dev/null 2>&1
	chmod +x /tmp/checkDMARC.sh && mv /tmp/checkDMARC.sh /usr/local/bin/checkDMARC > /dev/null 2>&1
	check "Agregando checkDMARC"
	## evil-winrm-py
	info "Descargando evil-winrm-py"
	apt remove python3-tqdm -y > /dev/null 2>&1
	pip3 install evil-winrm-py[kerberos] --break-system-packages > /dev/null 2>&1
	check "Agregando evil-winrm-py"
	## apk2url
	info "Descargando APK2URL"
	wget https://raw.githubusercontent.com/n0mi1k/apk2url/refs/heads/main/apk2url.sh -O /tmp/apk2url > /dev/null 2>&1
	chmod +x /tmp/apk2url && mv /tmp/apk2url /usr/local/bin/apk2url > /dev/null 2>&1
	check "Agregando apk2url"
	## BurpSuitePro
	info "Descargando BurpSuitePro"
	cd $WEB_PATH && mkdir BurpSuitePro 2> /dev/null
	wget "https://portswigger-cdn.net/burp/releases/download?product=pro&type=Jar" -O $WEB_PATH/BurpSuitePro/burpsuite_pro_v2025.4.5.jar > /dev/null 2>&1
	wget https://github.com/xiv3r/Burpsuite-Professional/raw/refs/heads/main/loader.jar -O $WEB_PATH/BurpSuitePro/loader.jar > /dev/null 2>&1
	cd $WEB_PATH/BurpSuitePro && echo "java --add-opens=java.desktop/javax.swing=ALL-UNNAMED --add-opens=java.base/java.lang=ALL-UNNAMED --add-opens=java.base/jdk.internal.org.objectweb.asm=ALL-UNNAMED --add-opens=java.base/jdk.internal.org.objectweb.asm.tree=ALL-UNNAMED --add-opens=java.base/jdk.internal.org.objectweb.asm.Opcodes=ALL-UNNAMED -javaagent:$(pwd)/loader.jar -noverify -jar $(pwd)/burpsuite_pro_v2025.4.5.jar >/dev/null 2>&1 &" > burpsuitepro 2>/dev/null
	chmod +x burpsuitepro && cp burpsuitepro /usr/local/bin > /dev/null 2>&1
	check "Agregando BurpSuitePro"
	## Prowler
	info "Descargando Prowler"
	pipx install prowler > /dev/null 2>&1
	check "Agregando Prowler"
	## rusthound-ce
	info "Descargando rusthound-ce"
	cargo install rusthound-ce > /dev/null 2>&1
	check "Agregando rusthound-ce"
	## jwt-hack
	info "Descargando jwt-hack"
	cargo install jwt-hack > /dev/null. 2>&1
	check "Agregando jwt-hack"
	## penelope
	info "Descargando penelope"
	cd /tmp && wget https://raw.githubusercontent.com/brightio/penelope/refs/heads/main/penelope.py > /dev/null 2>&1
	chmod +x /tmp/penelope.py && mv /tmp/penelope.py /usr/local/bin/penelope 2> /dev/null
	check "Agregando penelope"
	## NSE Scripts
	info "Descargando NSE Scripts adicionales"
	wget https://raw.githubusercontent.com/mmpx12/NSE-web-techno/master/web_techno.nse -O /usr/share/nmap/scripts/web_techno.nse > /dev/null 2>&1
	check "Agregando web_techno.nse"
	wget https://raw.githubusercontent.com/GossiTheDog/scanning/main/http-vuln-exchange.nse -O /usr/share/nmap/scripts/http-vuln-exchange.nse > /dev/null 2>&1
	check "Agregando http-vuln-exchange.nse"
	wget https://raw.githubusercontent.com/s4n7h0/NSE/master/http-lfi.nse -O /usr/share/nmap/scripts/http-lfi.nse > /dev/null 2>&1
	check "Agregando http-lfi.nse"
	wget https://raw.githubusercontent.com/psc4re/NSE-scripts/master/CVE-2021-21972.nse -O /usr/share/nmap/scripts/cve-2021-21972.nse > /dev/null 2>&1
	check "Agregando CVE-2021-21972.nse"
	wget https://raw.githubusercontent.com/psc4re/NSE-scripts/master/cve-2020-0796.nse -O /usr/share/nmap/scripts/smb3-smbghost.nse > /dev/null 2>&1
	check "Agregando cve-2020-0796.nse"
	wget https://raw.githubusercontent.com/psc4re/NSE-scripts/master/cve-2020-1350.nse -O /usr/share/nmap/scripts/cve-2020-1350.nse > /dev/null 2>&1
	check "Agregando cve-2020-1350.nse"
	wget https://raw.githubusercontent.com/psc4re/NSE-scripts/master/proxyshell.nse -O /usr/share/nmap/scripts/proxyshell.nse > /dev/null 2>&1
	check "Agregando proxyshell.nse"
	wget https://raw.githubusercontent.com/vulnersCom/nmap-vulners/master/http-vulners-regex.nse -O /usr/share/nmap/scripts/http-vulners-regex.nse > /dev/null 2>&1
	check "Agregando http-vulners-regex.nse"
	wget https://raw.githubusercontent.com/vulnersCom/nmap-vulners/master/http-vulners-regex.json -O /usr/share/nmap/nselib/data/http-vulners-regex.json > /dev/null 2>&1
	check "Agregando http-vulners-regex.json"
	wget https://raw.githubusercontent.com/vulnersCom/nmap-vulners/master/http-vulners-paths.txt -O /usr/share/nmap/nselib/data/http-vulners-paths.txt > /dev/null 2>&1
	check "Agregando http-vulners-paths.txt"
	wget https://raw.githubusercontent.com/hackertarget/nmap-nse-scripts/master/http-wordpress-info.nse -O /usr/share/nmap/scripts/http-wordpress-info.nse > /dev/null 2>&1
	check "Agregando http-wordpress-info.nse"
	wget https://raw.githubusercontent.com/hackertarget/nmap-nse-scripts/master/wp-themes.lst -O /usr/share/nmap/nselib/data/wp-themes.lst > /dev/null 2>&1
	check "Agregando wp-themes.lst"
	wget https://raw.githubusercontent.com/hackertarget/nmap-nse-scripts/master/wp-plugins.lst -O /usr/share/nmap/nselib/data/wp-plugins.lst > /dev/null 2>&1
	check "Agregando wp-plugins.lst"
	wget https://svn.nmap.org/nmap/scripts/clamav-exec.nse -O /usr/share/nmap/scripts/clamav-exec.nse >/dev/null 2>&1
	check "Agregando clamav-exec.nse"
	wget https://raw.githubusercontent.com/giterlizzi/nmap-log4shell/main/log4shell.nse -O /usr/share/nmap/scripts/log4shell.nse > /dev/null 2>&1
	check "Agregando log4shell.nse"
	wget https://raw.githubusercontent.com/claroty/CVE2020-0796/master/nse_script/smb2-capabilities_patched.nse -O /usr/share/nmap/smb2-capabilities_patched.nse >/dev/null 2>&1
	check "Agregando smb2-capabilities_patched.nse"
	wget https://raw.githubusercontent.com/GossiTheDog/scanning/main/http-vuln-exchange-proxyshell.nse -O /usr/share/nmap/scripts/http-vuln-exchange-proxyshell.nse >/dev/null 2>&1
	check "Agregando http-vuln-exchange-proxyshell.nse"
	wget https://raw.githubusercontent.com/CronUp/Vulnerabilidades/main/proxynotshell_checker.nse -O /usr/share/nmap/scripts/proxynotshell_checker.nse >/dev/null 2>&1
	check "Agregando proxynotshell_checker.nse"
	wget https://raw.githubusercontent.com/Diverto/nse-exchange/main/http-vuln-cve2022-41082.nse -O /usr/share/nmap/scripts/http-vuln-cve2022-41082.nse >/dev/null 2>&1
	check "Agregando http-vuln-cve2022-41082.nse"
	wget https://raw.githubusercontent.com/RootUp/PersonalStuff/master/http-vuln-cve-2021-41773.nse -O /usr/share/nmap/scripts/http-vuln-cve-2021-41773.nse >/dev/null 2>&1
	check "Agregando http-vuln-cve-2021-41773.nse"
	## Vulscan
	info "Descargando Vulscan NSE"
	cd $LINUX_PATH 2>/dev/null
	git clone https://github.com/scipag/vulscan scipag_vulscan > /dev/null 2>&1
	ln -s `pwd`/scipag_vulscan /usr/share/nmap/scripts/vulscan > /dev/null 2>&1
	check "Agregando Vulscan NSE"
	nmap --script-updatedb > /dev/null 2>&1
	check "Actualizando NSE scripts adicionales"
}

function installGithubTools(){
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
}