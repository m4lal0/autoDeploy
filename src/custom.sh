#!/bin/bash
#by @M4lal0

### Personalización de la terminal
function customTerminal(){
	section "COMENZANDO PERSONALIZACIÓN DEL SISTEMA"
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

	info "Instalando FZF"
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf > /dev/null 2>&1
	check "Clonando el repositorio de FZF (root)"
	echo -e "y\ny\nn" | ~/.fzf/install > /dev/null 2>&1
	check "Al instalar FZF (root)"
	git clone --depth 1 https://github.com/junegunn/fzf.git $HOME_PATH/.fzf > /dev/null 2>&1
	check "Clonando el repositorio de FZF ($USERNAME)"
	chown -R $USERNAME:$USERNAME $HOME_PATH/.fzf 2>/dev/null
	sudo -u $USERNAME $HOME_PATH/.fzf/install < <(echo -e "y\ny\nn") > /dev/null 2>&1
	check "Al instalar FZF ($USERNAME)"

	info "Configurando mate terminal"
	sudo -u $USERNAME dconf write /org/mate/terminal/profiles/default/copy-selection 'true' > /dev/null 2>&1
	sudo -u $USERNAME dconf write /org/mate/terminal/profiles/default/background-darkness '0.87130434782608701' > /dev/null 2>&1
	sudo -u $USERNAME dconf write /org/mate/terminal/profiles/default/background-color '#FFFFFFFFDDDD' > /dev/null 2>&1
	sudo -u $USERNAME dconf write /org/mate/terminal/profiles/default/bold-color '#000000000000' > /dev/null 2>&1
	sudo -u $USERNAME dconf write /org/mate/terminal/profiles/default/foreground-color '#000000000000' > /dev/null 2>&1
	sudo -u $USERNAME dconf write /org/mate/terminal/profiles/default/use-system-font 'false' > /dev/null 2>&1
	sudo -u $USERNAME dconf write /org/mate/terminal/profiles/default/font "'Hack Nerd Font Mono 11'" > /dev/null 2>&1
	sudo -u $USERNAME dconf write /org/mate/terminal/profiles/default/background-type "'transparent'" > /dev/null 2>&1
	check  "Al configurar mate terminal"

	info "Configurando escritorio"
	cp $FILES_PATH/xfce4/xfce4-desktop.xml $HOME_PATH/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml > /dev/null 2>&1
	chown -R $USERNAME:$USERNAME $HOME_PATH/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml 2>/dev/null
	check  "Al configurar fondo"
	cp $FILES_PATH/xfce4/xfce4-keyboard-shortcuts.xml $HOME_PATH/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml > /dev/null 2>&1
	chown -R $USERNAME:$USERNAME $HOME_PATH/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml 2>/dev/null
	check  "Al configurar atajos de teclado"
	cp $FILES_PATH/xfce4/thunar.xml $HOME_PATH/.config/xfce4/xfconf/xfce-perchannel-xml/thunar.xml > /dev/null 2>&1
	chown -R $USERNAME:$USERNAME $HOME_PATH/.config/xfce4/xfconf/xfce-perchannel-xml/thunar.xml 2>/dev/null
	check  "Al configurar ventanas"
	cp $FILES_PATH/xfce4/xfce4-panel.xml $HOME_PATH/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml > /dev/null 2>&1
	chown -R $USERNAME:$USERNAME $HOME_PATH/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml 2>/dev/null
	check  "Al configurar barra de tarea"
	cp $FILES_PATH/xfce4/xfwm4.xml $HOME_PATH/.config/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml > /dev/null 2>&1
	chown -R $USERNAME:$USERNAME $HOME_PATH/.config/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml 2>/dev/null
	check  "Al configurar paneles de trabajo"
	cp $FILES_PATH/scripts/ethstatus.sh $HOME_PATH/.config/ethstatus.sh > /dev/null 2>&1
	chmod 774 $HOME_PATH/.config/ethstatus.sh 2>/dev/null
	chown -R $USERNAME:$USERNAME $HOME_PATH/.config/ethstatus.sh 2>/dev/null
	check  "Al copiar script eth"
	cp $FILES_PATH/panel/genmon-4.rc $HOME_PATH/.config/xfce4/panel/genmon-4.rc > /dev/null 2>&1
	chown -R $USERNAME:$USERNAME $HOME_PATH/.config/xfce4/panel/genmon-4.rc 2>/dev/null
	check  "Al configurar info red (eth0) en barra de tarea"
	cp $FILES_PATH/scripts/vpnstatus.sh $HOME_PATH/.config/vpnstatus.sh > /dev/null 2>&1
	chmod 774 $HOME_PATH/.config/vpnstatus.sh 2>/dev/null
	chown -R $USERNAME:$USERNAME $HOME_PATH/.config/vpnstatus.sh 2>/dev/null
	check  "Al copiar script vpn"
	cp $FILES_PATH/panel/genmon-5.rc $HOME_PATH/.config/xfce4/panel/genmon-5.rc > /dev/null 2>&1
	chown -R $USERNAME:$USERNAME $HOME_PATH/.config/xfce4/panel/genmon-5.rc 2>/dev/null
	check  "Al configurar info red (tun0) en barra de tarea"
	cp $FILES_PATH/scripts/wifistatus.sh $HOME_PATH/.config/wifistatus.sh > /dev/null 2>&1
	chmod 774 $HOME_PATH/.config/wifistatus.sh 2>/dev/null
	chown -R $USERNAME:$USERNAME $HOME_PATH/.config/wifistatus.sh 2>/dev/null
	check  "Al copiar script wifi"
	cp $FILES_PATH/panel/genmon-24.rc $HOME_PATH/.config/xfce4/panel/genmon-24.rc > /dev/null 2>&1
	chown -R $USERNAME:$USERNAME $HOME_PATH/.config/xfce4/panel/genmon-24.rc 2>/dev/null
	check  "Al configurar info red (wlan0) en barra de tarea"
}