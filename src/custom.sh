#!/bin/bash
#by @M4lal0

### Personalización de la terminal
function customTerminal(){
	section "COMENZANDO PERSONALIZACIÓN DE LA TERMINAL"
	checkInternet
	info "Actualizando repositorios"
	apt update > /dev/null 2>&1

	info "Descargando fuente (Hack Nerd Font)"
	cd /usr/local/share/fonts/ 2>/dev/null
	wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip > /dev/null 2>&1
	check "Al descargar la fuente - https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip"
	unzip Hack.zip > /dev/null 2>&1
	rm Hack.zip 2>/dev/null

	info "Configurando shell predeterminada"
	usermod --shell /usr/bin/zsh root > /dev/null 2>&1
	usermod --shell /usr/bin/zsh $USERNAME > /dev/null 2>&1
	check "Aplicando shell predeterminada"

	info "Instalando powerlevel10k"
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME_PATH/powerlevel10k > /dev/null 2>&1
	check "En la clonación del repo de powerlevel10k"
	cp -r $HOME_PATH/powerlevel10k /root/ 2>/dev/null
	cp $FILES_PATH/.p10k.zsh $HOME_PATH/.p10k.zsh 2>/dev/null
	check "Al encontrar y colocar el $FILES_PATH/.p10k.zsh"
	ln -sf $HOME_PATH/.p10k.zsh /root/.p10k.zsh 2>/dev/null
	check "Agregando el p10k.zsh en root"

	info "Instalando lsd"
	#wget "https://github.com$(curl --silent https://github.com/Peltoche/lsd/releases | grep 'lsd_.*_amd64.deb' | awk -F '\"' '{print $2}' | head -n 1)" -O /tmp/lsd.deb > /dev/null 2>&1
	wget "https://github.com/Peltoche/lsd/releases/download/0.14.0/lsd_0.14.0_amd64.deb" -O /tmp/lsd.deb > /dev/null 2>&1
	check "Descargando el release de lsd"
	dpkg -i /tmp/lsd.deb > /dev/null 2>&1
	check "Instalación de lsd"

	info "Instalando bat"
	wget "https://github.com$(curl --silent https://github.com/sharkdp/bat/releases | grep 'bat_.*_amd64.deb' | awk -F '\"' '{print $2}' | head -n 1)" -O /tmp/bat.deb > /dev/null 2>&1
	check "Descargando el release de bat"
	dpkg -i /tmp/bat.deb > /dev/null 2>&1
	check "Instalación de bat"

	info "Configurando archivo zshrc"
	cp $FILES_PATH/.zshrc $HOME_PATH/.zshrc 2>/dev/null
	check "Al encontrar y colocar el $FILES_PATH/.zshrc"
	ln -sf $HOME_PATH/.zshrc /root/.zshrc 2>/dev/null
	check "Agregando el .zshrc en root"
	chown -R $USERNAME:$USERNAME $HOME_PATH/powerlevel10k $HOME_PATH/.p10k.zsh $HOME_PATH/.zshrc 2>/dev/null

	info "Estableciendo configuración de nano"
	cp $FILES_PATH/.nanorc $HOME_PATH/.nanorc 2>/dev/null
	check "Al encontrar $HOME_PATH/.nanorc"
	ln -sf $HOME_PATH/.nanorc /root/.nanorc 2>/dev/null
	check "Configuración de nano"
	chown -R $USERNAME:$USERNAME $HOME_PATH/.nanorc 2>/dev/null

	info "Configurando Oh my Tmux! ($USERNAME)"
	cd "$HOME_PATH"
	git clone https://github.com/gpakosz/.tmux.git > /dev/null 2>&1
	check "Al clonar Oh my Tmux!"
	chown -R $USERNAME:$USERNAME .tmux/ 2>/dev/null
	ln -s -f .tmux/.tmux.conf 2>/dev/null
	cp $FILES_PATH/.tmux.conf.local $HOME_PATH/.tmux.conf.local 2>/dev/null
	check "Al encontrar y colocar el $FILES_PATH/.tmux.conf.local"
	chown -R $USERNAME:$USERNAME .tmux.conf.local 2>/dev/null

	info "Configurando Oh my Tmux! (root)"
	cd
	git clone https://github.com/gpakosz/.tmux.git > /dev/null 2>&1
	check "Al clonar Oh my Tmux!"
	ln -s -f .tmux/.tmux.conf 2>/dev/null
	ln -sf $HOME_PATH/.tmux.conf.local /root/.tmux.conf.local
	check "Agregando el .tmux.conf.local en root"

}