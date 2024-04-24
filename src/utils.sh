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
function installApps(){
	section "COMENZANDO INSTALACIÓN DE UTILIDADES"
	checkInternet

	## Instalación de Firefox
	#info "Instalar Firefox"
	#wget https://download-installer.cdn.mozilla.net/pub/firefox/releases/99.0/linux-x86_64/en-US/firefox-99.0.tar.bz2 -O /opt/firefox-99.0.tar.bz2 > /dev/null 2>&1
	#check "Descargando Firefox"
	#cd /opt && tar -xf firefox-99.0.tar.bz2 > /dev/null 2>&1
	#rm -rf firefox-99.0.tar.bz2 2>/dev/null
	#check "Descomprimiendo archivo de Firefox"
	#cd /bin && mv firefox firefox2 && ln -sf /opt/firefox/firefox firefox 2>/dev/null
	#check "Instalando Firefox"

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
		su $USERNAME -c "nohup /bin/firejail /usr/bin/firefox &>/dev/null &; sleep 3; kill %1"
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
	wget https://addons.mozilla.org/firefox/downloads/file/4239079/wappalyzer-6.10.68.xpi > /dev/null 2>&1
	cp wappalyzer-6.10.68.xpi wappalyzer@crunchlabz.com.xpi 2>/dev/null
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
	wget https://addons.mozilla.org/firefox/downloads/file/4228676/foxyproxy_standard-8.9.xpi > /dev/null 2>&1
	cp foxyproxy_standard-8.9.xpi foxyproxy@eric.h.jung.xpi 2>/dev/null
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
	wget https://addons.mozilla.org/firefox/downloads/file/4200011/ip_address_and_domain_info-4.0.6.4.xpi > /dev/null 2>&1
	cp ip_address_and_domain_info-4.0.6.4.xpi jid0-jJRRRBMgoShUhb07IvnxTBAl29w@jetpack.xpi 2>/dev/null
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

	## Instalacion Brave
	info "Instalar Brave"
	curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add - > /dev/null 2>&1
	echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list > /dev/null 2>&1
	check "Descargando Brave"
	apt-get update -y > /dev/null 2>&1
	apt-get install brave-browser -y > /dev/null 2>&1
	if [ $? -ne 0 ]; then
		apt --fix-broken install -y > /dev/null 2>&1
		apt-get install brave-browser -y > /dev/null 2>&1
	fi
	check "Instalando Brave"

	info "Instalar Gotop"
	cd $SCRIPT_PATH ; git clone --depth 1 https://github.com/cjbassi/gotop /tmp/gotop > /dev/null 2>&1
	check "Clonando el repositorio de Gotop"
	/tmp/gotop/scripts/download.sh > /dev/null 2>&1
	check "Instalando Gotop"
	mv gotop /usr/local/bin 2>/dev/null
	check "Mover el binario de gotop a /usr/local/bin"

	## Instalación de paquetes con pip & pip3
	for ap in $(cat $PIP_TOOLS_LIST); do
		info "Instalando $(echo $ap | cut -d ':' -f 2)"
		$(echo $ap | cut -d ':' -f 1) install $(echo $ap | cut -d ':' -f 2) --break-system-packages > /dev/null 2>&1
		check "Instalando $(echo $ap | cut -d ':' -f 2) (root)"
		sudo -u $USERNAME $(echo $ap | cut -d ':' -f 1) install $(echo $ap | cut -d ':' -f 2) --break-system-packages > /dev/null 2>&1
		check "Instalando $(echo $ap | cut -d ':' -f 2) ($USERNAME)"
	done

	## Instalación de paquetes con go
	for ap in $(cat $GO_TOOLS_LIST); do
		info "Instalando $(echo $ap | cut -d ':' -f 1)"
		go install $(echo $ap | cut -d ':' -f 2) > /dev/null 2>&1
		check "Instalando $(echo $ap | cut -d ':' -f 1) (root)"
	done
}

### Instalacion de aplicaciones terceras en /opt/
function gitTools(){
	section "COMENZANDO INSTALACIÓN DE APLICACIONES DE TERCEROS"
	checkInternet
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
    check "Descomprimir archivo rockyou en /usr/share/wordlist/"
    cd 2>/dev/null
	## fuzzdb
	info "Descargando wordlists fuzzdb"
	cd /usr/share 2>/dev/null
	git clone --depth 1 https://github.com/fuzzdb-project/fuzzdb > /dev/null 2>&1
	ln -s `pwd`/fuzzdb /usr/share/wordlists > /dev/null 2>&1
	check "Agregando wordlist en /usr/share/wordlist/"
	## OneListForAll
	info "Descargando wordlists OneListForAll"
	cd /usr/share 2>/dev/null
	git clone --depth 1 https://github.com/six2dez/OneListForAll > /dev/null 2>&1
	ln -s `pwd`/OneListForAll /usr/share/wordlists > /dev/null 2>&1
	check "Agregando wordlist en /usr/share/wordlist/"
	## Kerberos-Enum-userlists
	info "Descargando wordlists Kerberos-Username-Enumeration"
	cd /usr/share 2>/dev/null
	git clone https://github.com/attackdebris/kerberos_enum_userlists > /dev/null 2>&1
	ln -s `pwd`/kerberos_enum_userlists /usr/share/wordlists > /dev/null 2>&1
	check "Agregando wordlist en /usr/share/wordlist/"
	## Others Wordlists
	info "Descargando otras wordlists"
	cd /usr/share 2>/dev/null
	mkdir trickest; cd trickest; git clone https://github.com/trickest/wordlists > /dev/null 2>&1
	cd wordlists; mv inventory robots technologies technology-repositories.json ../ && rm -rf wordlists 2>&1
	ln -s /usr/share/trickest /usr/share/wordlists > /dev/null 2>&1
	check "Agregando wordlist en /usr/share/wordlist/trickest"
	## WordPress Exploit Framework
	info "Instalando WordPress Exploit Framework"
	cd /
	gem install wpxf > /dev/null 2>&1
	check "Agregando WordPress Exploit Framework"


## Git clone con instalación aparte
	info "Directorios de aplicativos"
	mkdir {$PRIVESCLIN_PATH,$PRIVESCWIN_PATH,$OSINT_PATH,$UTILITIES_PATH,$WEB_PATH,$WIFI_PATH,$WORDPRESS_PATH,$AD_PATH} 2>/dev/null
	check "Creando directorios"
	## GTFOBLookup
	info "Descargando GTFOBLookup"
	cd $UTILITIES_PATH 2>/dev/null
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
	cd $UTILITIES_PATH 2>/dev/null
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
	git clone --depth 1 https://github.com/whoot/Typo3Scan.git > /dev/null 2>&1
	cd Typo3Scan && pip install -r requirements.txt --break-system-packages > /dev/null 2>&1
	check "Agregando Typo3Scan"
	## Reverse Shell Generator
	info "Descargando Reverse Shell Generator"
	cd $UTILITIES_PATH 2>/dev/null
	git clone https://github.com/mthbernardes/rsg.git > /dev/null 2>&1
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
	cd $UTILITIES_PATH 2>/dev/null
	git clone https://github.com/nitefood/asn >/dev/null 2>&1
	ln -sf $UTILITIES_PATH/asn/asn /usr/local/bin/asn >/dev/null 2>&1
	check "Agregando asn"
	## PyShell
	info "Descargando PyShell"
	cd $WEB_PATH 2>/dev/null
	git clone https://github.com/JoelGMSec/PyShell >/dev/null 2>&1
	cd PyShell ; pip install -r requirements.txt --break-system-packages >/dev/null 2>&1
	check "Agregando PyShell"
	## Ghauri
	info "Descargando ghauri"
	cd $UTILITIES_PATH 2>/dev/null
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
	check "Agregando wwwtree"
	## ligolo-ng
	info "Descargando ligolo-ng"
	cd $UTILITIES_PATH 2>/dev/null
	git clone https://github.com/nicocha30/ligolo-ng >/dev/null 2>&1
	cd ligolo-ng
	go build -o bin/ligolo-agent cmd/agent/main.go >/dev/null 2>&1
	go build -o bin/ligolo-proxy cmd/proxy/main.go >/dev/null 2>&1
	GOOS=windows go build -o bin/ligolo-agent.exe cmd/agent/main.go >/dev/null 2>&1
	GOOS=windows go build -o bin/ligolo-proxy.exe cmd/proxy/main.go >/dev/null 2>&1
	mv $UTILITIES_PATH/ligolo-ng/bin/ligolo-proxy /usr/local/bin > /dev/null 2>&1
	check "Agregando ligolo-ng"
	## wifi_db
	info "Instalando wifi_db"
	cd $WIFI_PATH && git clone https://github.com/r4ulcl/wifi_db > /dev/null 2>&1
	cd wifi_db && pip3 install -r requirements.txt --break-system-packages > /dev/null 2>&1
	check "Agregando wifi_db"
	## UploadBypass
	info "Instalando Upload_Bypass"
	cd $WEB_PATH && wget https://github.com/sAjibuu/Upload_Bypass/releases/download/v2.0.8-offical/Upload_Bypass_v2.0.8-offical.zip > /dev/null 2>&1
	unzip Upload_Bypass_v2.0.8-offical.zip > /dev/null 2>&1
	rm Upload_Bypass_v2.0.8-offical.zip 2>/dev/null
	check "Agregando Upload_Bypass"
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
	### CrackMapExec
	#info "Instalando CrackMapExec"
	#cd $UTILITIES_PATH 2>/dev/null
	#git clone https://github.com/byt3bl33d3r/CrackMapExec >/dev/null 2>&1
	#cd CrackMapExec && poetry install >/dev/null 2>&1
	#check "Agregando CrackMapExec"

	## Eternalblue-Doublepulsar-Metasploit
	info "Descargando modulo Eternalblue-Doublepulsar para Metasploit"
	cd $UTILITIES_PATH 2>/dev/null
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
	wget "https://github.com/muesli/duf/releases/latest/download/duf_0.8.1_linux_amd64.deb" -O /tmp/duf_0.8.1_linux_amd64.deb > /dev/null 2>&1
	dpkg -i /tmp/duf_0.8.1_linux_amd64.deb > /dev/null 2>&1
	check "Agregando duf"
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
	wget "https://github.com/RustScan/RustScan/releases/download/2.0.1/rustscan_2.0.1_amd64.deb" -O /tmp/rustscan_2.0.1_amd64.deb > /dev/null 2>&1
	dpkg -i /tmp/rustscan_2.0.1_amd64.deb > /dev/null 2>&1
	check "Agregando RustScan"
	## tempomail
	info "Descargando tempomail"
	cd /tmp/ 2>/dev/null
	wget https://github.com/kavishgr/tempomail/releases/latest/download/linux-amd64-tempomail.tgz > /dev/null 2>&1
	tar -xf linux-amd64-tempomail.tgz > /dev/null 2>&1
	mv tempomail /usr/local/bin/ > /dev/null 2>&1
	check "Agregando tempomail"
	## ABE (Android-Backup-Extractor)
	info "Descargando Android-Backup-Extractor"
	mkdir $UTILITIES_PATH/Android-Backup-Extractor && wget "https://github.com/nelenkov/android-backup-extractor/releases/download/master-20221109063121-8fdfc5e/abe.jar" -O $UTILITIES_PATH/Android-Backup-Extractor/abe.jar > /dev/null 2>&1
	check "Agregando Android-Backup-Extractor"
	## Venom
	info "Descargando venom"
	curl https://github.com/ovh/venom/releases/download/v1.1.0/venom.linux-amd64 -L -o /usr/local/bin/venom > /dev/null 2>&1
	chmod +x /usr/local/bin/venom
	check "Agregando venom"
	## CORS
	info "Descargando CORS"
	mkdir $WEB_PATH/CORS &&	wget https://raw.githubusercontent.com/gwen001/pentest-tools/master/cors.py -O $WEB_PATH/CORS/cors.py > /dev/null 2>&1
	check "Agregando cors.py"
	## Rustcat
	info "Descargando rustcat"
	wget "https://github.com/robiot/rustcat/releases/latest/download/rcat-v3.0.0-linux-x86_64.deb" -O /tmp/rcat-v3.0.0-linux-x86_64.deb > /dev/null 2>&1
	cd /tmp && sudo apt install ./rcat-v3.0.0-linux-x86_64.deb  > /dev/null 2>&1
	if [ $? -ne 0 ]; then
		apt --fix-broken install -y > /dev/null 2>&1
		sudo apt install ./rcat-v3.0.0-linux-x86_64.deb > /dev/null 2>&1
	fi
	check "Agregando rustcat"
	## BloodHound
	info "Descargando BloodHound"
	cd $AD_PATH 2>/dev/null
	wget https://github.com/BloodHoundAD/BloodHound/releases/download/4.0.3/BloodHound-linux-x64.zip > /dev/null 2>&1
	unzip BloodHound-linux-x64.zip > /dev/null 2>&1
	rm BloodHound-linux-x64.zip > /dev/null 2>&1
	mv BloodHound-linux-x64 BloodHound 2>/dev/null
	check "Agregando BloodHound 4.0.3"
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
	wget https://github.com/r3motecontrol/Ghostpack-CompiledBinaries/raw/master/Rubeus.exe -O $AD_PATH/Rubeus/Rubeus.exe > /dev/null 2>&1
	check "Agregando Rubeus.exe"
	## SharpHound
	info "Descargando SharpHound.ps1"
	cd $AD_PATH && mkdir SharpHound 2>/dev/null
	wget https://raw.githubusercontent.com/puckiestyle/powershell/master/SharpHound.ps1 -O $AD_PATH/SharpHound/SharpHound.ps1 > /dev/null 2>&1
	check "Agregando SharpHound.ps1"
	## SafetyKatz.exe
	info "Descargando SafetyKatz.exe"
	cd $AD_PATH && mkdir SafetyKatz 2>/dev/null
	wget https://github.com/r3motecontrol/Ghostpack-CompiledBinaries/raw/master/SafetyKatz.exe -O $AD_PATH/SafetyKatz/SafetyKatz.exe > /dev/null 2>&1
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
	cd $PRIVESCWIN_PATH && mkdir winPEAS 2>/dev/null
	wget https://github.com/carlospolop/PEASS-ng/releases/latest/download/winPEASx64.exe -O $PRIVESCWIN_PATH/winPEAS/winPEASx64.exe > /dev/null 2>&1
	wget https://github.com/carlospolop/PEASS-ng/releases/latest/download/winPEASx86.exe -O $PRIVESCWIN_PATH/winPEAS/winPEASx86.exe > /dev/null 2>&1
	wget https://github.com/carlospolop/PEASS-ng/releases/latest/download/winPEASany.exe -O $PRIVESCWIN_PATH/winPEAS/winPEASany.exe > /dev/null 2>&1
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
	wget https://github.com/mandiant/capa/releases/download/v7.0.1/capa-v7.0.1-linux.zip -O /tmp/capa-v7.0.1-linux.zip > /dev/null 2>&1
	cd /tmp && unzip /tmp/capa-v7.0.1-linux.zip > /dev/null 2>&1
	mv /tmp/capa /usr/local/bin
	check "Agregando CAPA"
	## IPATool
	info "Descargando IPAtool"
	wget https://github.com/majd/ipatool/releases/download/v2.1.4/ipatool-2.1.4-linux-amd64.tar.gz -O /tmp/ipatool-2.1.4-linux-amd64.tar.gz > /dev/null 2>&1
	cd /tmp && tar -xzf /tmp/ipatool-2.1.4-linux-amd64.tar.gz > /dev/null 2>&1
	chmod +x /tmp/bin/ipatool-2.1.4-linux-amd64
	mv /tmp/bin/ipatool-2.1.4-linux-amd64 /usr/local/bin/ipatool
	check "Agregando IPAtool"
	## Govenom
	info "Descargando Govenom"
	wget https://github.com/arch3rPro/Govenom/releases/latest/download/darwin_amd64.tar.gz -O /tmp/darwin_amd64.tar.gz > /dev/null 2>&1
	cd /tmp && tar -xzf /tmp/darwin_amd64.tar.gz > /dev/null 2>&1
	mv /tmp/Govenom /usr/local/bin
	check "Instalando Govenom"
	## NetExec
	info "Instalando NetExec"
	cd /tmp 2>/dev/null
	wget https://github.com/Pennyw0rth/NetExec/releases/latest/download/nxc >/dev/null 2>&1
	chmod 777 nxc && mv /tmp/nxc /usr/local/bin/NetExec >/dev/null 2>&1
	check "Agregando NetExec"
	## RunasCs
	info "Descargando RunasCs"
	cd $PRIVESCWIN_PATH && mkdir RunasCs 2>/dev/null
	wget https://github.com/antonioCoco/RunasCs/releases/download/v1.5/RunasCs.zip -O $PRIVESCWIN_PATH/RunasCs/RunasCs.zip > /dev/null 2>&1
	cd $PRIVESCWIN_PATH/RunasCs && unzip RunasCs.zip > /dev/null 2>&1
	rm -f $PRIVESCWIN_PATH/RunasCs/RunasCs.zip > /dev/null 2>&1
	check "Agregando RunasCs"
	## Seatbelt.exe
	info "Descargando Seatbelt.exe"
	cd $PRIVESCWIN_PATH && mkdir Seatbelt 2>/dev/null
	wget https://github.com/r3motecontrol/Ghostpack-CompiledBinaries/raw/master/Seatbelt.exe -O $PRIVESCWIN_PATH/Seatbelt/Seatbelt.exe > /dev/null 2>&1
	check "Agregando Seatbelt.exe"
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
	cd $UTILITIES_PATH 2>/dev/null
	git clone https://github.com/scipag/vulscan scipag_vulscan > /dev/null 2>&1
	ln -s `pwd`/scipag_vulscan /usr/share/nmap/scripts/vulscan > /dev/null 2>&1
	check "Agregando Vulscan NSE"
	nmap --script-updatedb > /dev/null 2>&1
	check "Actualizando NSE scripts adicionales"

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