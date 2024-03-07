#!/usr/bin/env bash
#by @m4lal0

### Personalización de la terminal
function customTerminal(){
	section "COMENZANDO PERSONALIZACIÓN DEL SISTEMA"
	checkInternet
	info "Actualizando repositorios"
	apt update > /dev/null 2>&1

	info "Descargando fuente (Hack Nerd Font)"
	cd /usr/local/share/fonts/ 2>/dev/null
	wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/Hack.zip > /dev/null 2>&1
	check "Descargando la fuente - https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/Hack.zip"
	unzip Hack.zip > /dev/null 2>&1
	check "Instalando la fuente Hack Nerd Font"
	rm Hack.zip 2>/dev/null

	#info "Descargando fuente (Fira Code Nerd)"
	#cd /usr/local/share/fonts/ 2>/dev/null
	#wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/FiraCode.zip > /dev/null 2>&1
	#check "Descargando la fuente - https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/FiraCode.zip"
	#unzip FiraCode.zip > /dev/null 2>&1
	#check "Instalando la fuente Fira Code"
	#rm FiraCode.zip 2>/dev/null
	#wget https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FiraCode/Regular/complete/Fira%20Code%20Regular%20Nerd%20Font%20Complete.ttf > /dev/null 2>&1

	info "Configurando shell predeterminada"
	usermod --shell /usr/bin/zsh root > /dev/null 2>&1
	check "Aplicando shell predeterminada para root"
	usermod --shell /usr/bin/zsh $USERNAME > /dev/null 2>&1
	check "Aplicando shell predeterminada para $USERNAME"

	info "Instalando powerlevel10k"
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME_PATH/powerlevel10k > /dev/null 2>&1
	check "Clonando el repositorio de powerlevel10k"
	cp -r $HOME_PATH/powerlevel10k /root/ 2>/dev/null
	cp $FILES_PATH/.p10k.zsh $HOME_PATH/.p10k.zsh 2>/dev/null
	check "Al encontrar y colocar el $FILES_PATH/.p10k.zsh"
	ln -sf $HOME_PATH/.p10k.zsh /root/.p10k.zsh 2>/dev/null
	check "Agregando el p10k.zsh en root"

	info "Instalando lsd"
	wget "https://github.com/Peltoche/lsd/releases/download/0.23.0/lsd_0.23.0_amd64.deb" -O /tmp/lsd.deb > /dev/null 2>&1
	check "Descargando lsd"
	dpkg -i /tmp/lsd.deb > /dev/null 2>&1
	check "Instalación de lsd"

	info "Instalando bat"
	wget "https://github.com/sharkdp/bat/releases/download/v0.22.0/bat_0.22.0_amd64.deb" -O /tmp/bat.deb > /dev/null 2>&1
	check "Descargando bat"
	dpkg -i /tmp/bat.deb > /dev/null 2>&1
	check "Instalación de bat"

	info "Instalando comando fd"
	ln -s $(which fdfind) /usr/local/bin/fd > /dev/null 2>&1
	check "Configurar comando fd"

	info "Configurando archivo zshrc"
	cp $FILES_PATH/.zshrc $HOME_PATH/.zshrc 2>/dev/null
	check "Al encontrar y colocar el $FILES_PATH/.zshrc"
	ln -sf $HOME_PATH/.zshrc /root/.zshrc 2>/dev/null
	check "Agregando el .zshrc en root"
	chown -R $USERNAME:$USERNAME $HOME_PATH/powerlevel10k $HOME_PATH/.p10k.zsh $HOME_PATH/.zshrc 2>/dev/null
	check "Configurando permisos para .zshrc"

	info "Configurando plugins zsh"
	cd /usr/share && mkdir zsh-sudo 2>&1
	cd zsh-sudo && wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/sudo/sudo.plugin.zsh > /dev/null 2>&1
	check "Agregando plugin sudo zsh"
	cd /usr/share && mkdir zsh-command-not-found 2>&1
	cd zsh-command-not-found && wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/command-not-found/command-not-found.plugin.zsh > /dev/null 2>&1
	check "Agregando plugin command-not-found zsh"
	cd /usr/share && git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git > /dev/null 2>&1
	check "Agregando plugin autocomplete zsh"
	cd /usr/share && chown -R $USERNAME:$USERNAME zsh-* 2>/dev/null
	check "Configurando permisos para plugins"
	cd

	info "Estableciendo configuración de nano"
	cp $FILES_PATH/.nanorc $HOME_PATH/.nanorc 2>/dev/null
	check "Al encontrar $HOME_PATH/.nanorc"
	ln -sf $HOME_PATH/.nanorc /root/.nanorc 2>/dev/null
	check "Configuración de nano"
	chown -R $USERNAME:$USERNAME $HOME_PATH/.nanorc 2>/dev/null
	check "Configurando permisos para nano"

	info "Estableciendo configuración de vim"
	wget https://raw.githubusercontent.com/arcticicestudio/nord-vim/main/colors/nord.vim -O /usr/share/vim/vim91/colors/nord.vim > /dev/null 2>&1
	check "Descargando color para vim"
	cp $FILES_PATH/.vimrc $HOME_PATH/.vimrc 2>/dev/null
	check "Al encontrar $HOME_PATH/.vimrc"
	ln -sf $HOME_PATH/.vimrc /root/.vimrc 2>/dev/null
	check "Configuración de vim"

	info "Descargando archivos adicionales de Nano Syntax"
	wget https://raw.githubusercontent.com/scopatz/nanorc/master/powershell.nanorc -O /usr/share/nano/powershell.nanorc > /dev/null 2>&1
	check "Descargado powershell.nanorc en /usr/share/nano/"
	wget https://raw.githubusercontent.com/scopatz/nanorc/master/js.nanorc -O /usr/share/nano/js.nanorc > /dev/null 2>&1
	check "Descargado js.nanorc en /usr/share/nano/"
	wget https://raw.githubusercontent.com/scopatz/nanorc/master/markdown.nanorc -O /usr/share/nano/markdown.nanorc > /dev/null 2>&1
	check "Descargado markdown.nanorc en /usr/share/nano/"
	wget https://raw.githubusercontent.com/scopatz/nanorc/master/arduino.nanorc -O /usr/share/nano/arduino.nanorc > /dev/null 2>&1
	check "Descargado arduino.nanorc en /usr/share/nano/"
	wget https://raw.githubusercontent.com/scopatz/nanorc/master/sql.nanorc -O /usr/share/nano/sql.nanorc > /dev/null 2>&1
	check "Descargado sql.nanorc en /usr/share/nano/"
	wget https://raw.githubusercontent.com/scopatz/nanorc/master/Dockerfile.nanorc -O /usr/share/nano/Dockerfile.nanorc > /dev/null 2>&1
	check "Descargado Dockerfile.nanorc en /usr/share/nano/"
	wget https://raw.githubusercontent.com/mitchell486/nanorc/master/bat.nanorc -O /usr/share/nano/bat.nanorc > /dev/null 2>&1
	check "Descargado bat.nanorc en /usr/share/nano/"

	info "Configurando Oh my Tmux! ($USERNAME)"
	cd "$HOME_PATH"
	git clone https://github.com/gpakosz/.tmux.git > /dev/null 2>&1
	check "Clonando repositorio Oh my Tmux!"
	chown -R $USERNAME:$USERNAME .tmux/ 2>/dev/null
	ln -s -f .tmux/.tmux.conf 2>/dev/null
	cp $FILES_PATH/.tmux.conf.local $HOME_PATH/.tmux.conf.local 2>/dev/null
	check "Al encontrar y colocar el $FILES_PATH/.tmux.conf.local"
	chown -R $USERNAME:$USERNAME .tmux.conf.local 2>/dev/null
	check "Configurando permisos para tmux"

	info "Configurando Oh my Tmux! (root)"
	cd
	git clone https://github.com/gpakosz/.tmux.git > /dev/null 2>&1
	check "Clonando repositorio Oh my Tmux!"
	ln -s -f .tmux/.tmux.conf 2>/dev/null
	ln -sf $HOME_PATH/.tmux.conf.local /root/.tmux.conf.local
	check "Agregando el .tmux.conf.local en root"

	info "Instalando FZF"
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf > /dev/null 2>&1
	check "Clonando el repositorio de FZF (root)"
	echo -e "y\ny\nn" | ~/.fzf/install > /dev/null 2>&1
	check "Instalar FZF (root)"
	git clone --depth 1 https://github.com/junegunn/fzf.git $HOME_PATH/.fzf > /dev/null 2>&1
	check "Clonando el repositorio de FZF ($USERNAME)"
	chown -R $USERNAME:$USERNAME $HOME_PATH/.fzf 2>/dev/null
	sudo -u $USERNAME $HOME_PATH/.fzf/install < <(echo -e "y\ny\nn") > /dev/null 2>&1
	check "Instalar FZF ($USERNAME)"

	info "Configurando rofi"
	mkdir $HOME_PATH/.config/rofi && cd $HOME_PATH/.config/rofi
	wget https://raw.githubusercontent.com/VaughnValle/blue-sky/master/nord.rasi -O /usr/share/rofi/themes/nord.rasi > /dev/null 2>&1
	check "Descargando tema para rofi"
	echo "rofi.theme: /usr/share/rofi/themes/nord.rasi" > config 2>/dev/null
	check "Configurando tema para rofi"
	chmod 644 config > /dev/null 2>&1
	chown -R $USERNAME:$USERNAME $HOME_PATH/.config/rofi 2>/dev/null
	check "Configurando rofi ($USERNAME)"
	cd
	if [ -d .config ]; then
		ln -sf $HOME_PATH/.config/rofi /root/.config/rofi 2>/dev/null
		check "Configurando rofi (root)"
	else
		mkdir .config && ln -sf $HOME_PATH/.config/rofi /root/.config/rofi 2>/dev/null
		check "Configurando rofi (root)"
	fi

	info "Configurando findex"
	wget https://github.com/mdgaziur/findex/releases/download/v0.8.1/findex-0.8.1-x86_64.tar.gz -O /tmp/findex-0.8.1-x86_64.tar.gz > /dev/null 2>&1
	tar -xzf /tmp/findex-0.8.1-x86_64.tar.gz -C /tmp/ > /dev/null 2>&1
	mv /tmp/findex-0.8.1-x86_64/findex /usr/bin 2>/dev/null
	chown root:$USERNAME /usr/bin/findex 2>/dev/null
	check "Configurando findex"

	info "Configurando qterminal del usuario"
	if [ ! -d $HOME_PATH/qterminal.org ]; then
		mkdir $HOME_PATH/qterminal.org 2> /dev/null
	fi
	cp -f $FILES_PATH/qterminal.ini $HOME_PATH/.config/qterminal.org/ 2>/dev/null
	check "Copiando archivo de configuración de qterminal del usuario"
	perl -pi -e "s[USER-PATH][$HOME_PATH/]g" $HOME_PATH/.config/qterminal.org/qterminal.ini 2>/dev/null
	check "Configurando archivo de qterminal del usuario"

	info "Configurando qterminal de root"
	if [ ! -d /root/.config/qterminal.org ]; then
		mkdir /root/.config/qterminal.org 2> /dev/null
	fi
	cp -f $FILES_PATH/qterminal.ini /root/.config/qterminal.org/ 2>/dev/null
	check "Copiando archivo de configuración de qterminal de root"
	perl -pi -e "s[USER-PATH][/root/.config/]g" /root/.config/qterminal.org/qterminal.ini 2>/dev/null
	check "Configurando archivo de qterminal de root"

	info "Configurando escritorio"
	wget "https://gitlab.com/kalilinux/packages/kali-wallpapers/-/raw/kali/master/2020.4/backgrounds/kali/kali-geometric-16x9.png?inline=false" -O /usr/share/backgrounds/kali/kali-geometric-16x9.png > /dev/null 2>&1
	check "Descargando fondo kali-geometric"
	wget "https://gitlab.com/kalilinux/packages/kali-wallpapers/-/raw/kali/master/2020.4/backgrounds/kali/kali-light-strips-16x9.png?inline=false" -O /usr/share/backgrounds/kali/kali-light-strips-16x9.png > /dev/null 2>&1
	check "Descargando fondo kali-light-strips"
	wget "https://gitlab.com/kalilinux/packages/kali-wallpapers/-/raw/kali/master/2020.4/backgrounds/kali/kali-contours-16x9.png?inline=false" -O /usr/share/backgrounds/kali/kali-contours-16x9.png > /dev/null 2>&1
	check "Descargando fondo kali-contours"
	wget "https://gitlab.com/kalilinux/packages/kali-wallpapers/-/raw/kali/master/2022/backgrounds/kali/kali-abstract-sky-16x9.png?ref_type=heads&inline=false" -O /usr/share/backgrounds/kali/kali-abstract-sky-16x9.png > /dev/null 2>&1
	check "Descargando fondo kali-abstract-sky"
	wget "https://gitlab.com/kalilinux/packages/kali-wallpapers/-/raw/kali/master/legacy/backgrounds/kali-2.0/kali-2.0-1920x1080.png?inline=false" -O /usr/share/backgrounds/kali/kali-2.0-1920x1080.png > /dev/null 2>&1
	check "Descargando fondo kali-2.0"
	wget "https://gitlab.com/kalilinux/packages/kali-wallpapers/-/raw/kali/master/2023/backgrounds/kali/kali-cubism-16x9.jpg?ref_type=heads&inline=false" -O /usr/share/backgrounds/kali/kali-cubism-16x9.png > /dev/null 2>&1
	check "Descargando fondo kali-cubism"
	wget "https://gitlab.com/kalilinux/packages/kali-wallpapers/-/raw/kali/master/2022/backgrounds/kali/kali-actiniaria-16x9.png?inline=false" -O /usr/share/backgrounds/kali/kali-actiniaria-16x9.png > /dev/null 2>&1
	check "Descargando fondo kali-actiniaria"
	wget "https://gitlab.com/kalilinux/packages/kali-wallpapers/-/raw/kali/master/2020.4/backgrounds/kali/kali-neon-16x9.png?inline=false" -O /usr/share/backgrounds/kali/kali-neon-16x9.png > /dev/null 2>&1
	check "Descargando fondo kali-neon"
	wget "https://gitlab.com/kalilinux/packages/kali-wallpapers/-/raw/kali/master/2023/backgrounds/kali/kali-laminaria-16x9.png?inline=false" -O /usr/share/backgrounds/kali/kali-laminaria-16x9.png > /dev/null 2>&1
	check "Descargando fondo kali-laminaria"
	wget "https://gitlab.com/kalilinux/packages/kali-wallpapers/-/raw/kali/master/2023/backgrounds/kali/kali-red-sticker-16x9.jpg?inline=false" -O /usr/share/backgrounds/kali/kali-red-sticker-16x9.jpg > /dev/null 2>&1
	check "Descargando fondo kali-red-sticker"
	wget "https://gitlab.com/kalilinux/packages/kali-wallpapers/-/raw/kali/master/2024/backgrounds/kali/kali-aqua-16x9.jpg?ref_type=heads&inline=false" -O /usr/share/backgrounds/kali/kali-aqua-16x9.jpg > /dev/null 2>&1
	check "Descargando fondo kali-aqua"
	wget "https://gitlab.com/kalilinux/packages/kali-wallpapers/-/raw/kali/master/2024/backgrounds/kali/kali-metal-16x9.jpg?ref_type=heads&inline=false" -O /usr/share/backgrounds/kali/kali-metal-16x9.jpg > /dev/null 2>&1
	check "Descargando fondo kali-metal"
	wget "https://gitlab.com/kalilinux/packages/kali-wallpapers/-/raw/kali/master/2024/backgrounds/kali/kali-metal-dark-16x9.png?ref_type=heads&inline=false" -O /usr/share/backgrounds/kali/kali-metal-dark-16x9.png > /dev/null 2>&1
	check "Descargando fondo kali-metal-dark"
	ln -s /usr/share/backgrounds/kali/kali-geometric-16x9.png /usr/share/backgrounds/kali-16x9/kali-geometric-16x9.png > /dev/null 2>&1
	ln -s /usr/share/backgrounds/kali/kali-light-strips-16x9.png /usr/share/backgrounds/kali-16x9/kali-light-strips-16x9.png > /dev/null 2>&1
	ln -s /usr/share/backgrounds/kali/kali-abstract-sky-16x9.png /usr/share/backgrounds/kali-16x9/kali-abstract-sky-16x9.png > /dev/null 2>&1
	ln -s /usr/share/backgrounds/kali/kali-contours-16x9.png /usr/share/backgrounds/kali-16x9/kali-contours-16x9.png > /dev/null 2>&1
	ln -s /usr/share/backgrounds/kali/kali-2.0-1920x1080.png /usr/share/backgrounds/kali-16x9/kali-2.0-1920x1080.png > /dev/null 2>&1
	ln -s /usr/share/backgrounds/kali/kali-cubism-16x9.png /usr/share/backgrounds/kali-16x9/kali-cubism-16x9.png > /dev/null 2>&1
	ln -s /usr/share/backgrounds/kali/kali-actiniaria-16x9.png /usr/share/backgrounds/kali-16x9/kali-actiniaria-16x9.png > /dev/null 2>&1
	ln -s /usr/share/backgrounds/kali/kali-neon-16x9.png /usr/share/backgrounds/kali-16x9/kali-neon-16x9.png > /dev/null 2>&1
	ln -s /usr/share/backgrounds/kali/kali-laminaria-16x9.png /usr/share/backgrounds/kali-16x9/kali-laminaria-16x9.png > /dev/null 2>&1
	ln -s /usr/share/backgrounds/kali/kali-red-sticker-16x9.jpg /usr/share/backgrounds/kali-16x9/kali-red-sticker-16x9.jpg > /dev/null 2>&1
	ln -s /usr/share/backgrounds/kali/kali-aqua-16x9.jpg /usr/share/backgrounds/kali-16x9/kali-aqua-16x9.jpg > /dev/null 2>&1
	ln -s /usr/share/backgrounds/kali/kali-metal-16x9.jpg /usr/share/backgrounds/kali-16x9/kali-metal-16x9.jpg > /dev/null 2>&1
	ln -s /usr/share/backgrounds/kali/kali-metal-dark-16x9.png /usr/share/backgrounds/kali-16x9/kali-metal-dark-16x9.png > /dev/null 2>&1
	check "Configurando fondos"
	unlink /usr/share/desktop-base/kali-theme/login/background > /dev/null 2>&1
	ln -s /usr/share/backgrounds/kali-16x9/kali-metal-16x9.jpg /usr/share/desktop-base/kali-theme/login/background > /dev/null 2>&1
	check "Configurando fondo de inicio de sesión"
	cp $FILES_PATH/xfce4/xfce4-desktop.xml $HOME_PATH/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml > /dev/null 2>&1
	chown -R $USERNAME:$USERNAME $HOME_PATH/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml 2>/dev/null
	check "Configurando fondo de escritorio"
	cp $FILES_PATH/xfce4/xfce4-keyboard-shortcuts.xml $HOME_PATH/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml > /dev/null 2>&1
	chown -R $USERNAME:$USERNAME $HOME_PATH/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml 2>/dev/null
	check "Configurando atajos de teclado"
	cp $FILES_PATH/xfce4/thunar.xml $HOME_PATH/.config/xfce4/xfconf/xfce-perchannel-xml/thunar.xml > /dev/null 2>&1
	chown -R $USERNAME:$USERNAME $HOME_PATH/.config/xfce4/xfconf/xfce-perchannel-xml/thunar.xml 2>/dev/null
	check "Configurando ventanas"
	cp $FILES_PATH/xfce4/xfce4-panel.xml $HOME_PATH/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml > /dev/null 2>&1
	chown -R $USERNAME:$USERNAME $HOME_PATH/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml 2>/dev/null
	check "Configurando barra de tarea"
	cp $FILES_PATH/xfce4/xfwm4.xml $HOME_PATH/.config/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml > /dev/null 2>&1
	chown -R $USERNAME:$USERNAME $HOME_PATH/.config/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml 2>/dev/null
	check "Configurando paneles de trabajo"
	cp $FILES_PATH/xfce4/xfce4-power-manager.xml $HOME_PATH/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml > /dev/null 2>&1
	chown -R $USERNAME:$USERNAME $HOME_PATH/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-power-manager.xml 2>/dev/null
	check "Configurando administrador de energia"
	cd $FILES_PATH/xfce4 2>/dev/null
	tar -xJf Sweet-Rainbow.tar.xz && tar -xJf candy-icons.tar.xz > /dev/null 2>&1
	mkdir $HOME_PATH/.local/share/icons && mv $FILES_PATH/xfce4/Sweet-Rainbow $FILES_PATH/xfce4/candy-icons $HOME_PATH/.local/share/icons > /dev/null 2>&1
	chown -R $USERNAME:$USERNAME $HOME_PATH/.local/share/icons 2>/dev/null
	check  "Configurando iconos ($USERNAME)"
	mkdir -p /root/.local/share && ln -s $HOME_PATH/.local/share/icons /root/.local/share/icons 2>/dev/null
	check "Configurando iconos (root)"
	cp $FILES_PATH/xfce4/xsettings.xml $HOME_PATH/.config/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml > /dev/null 2>&1
	chown -R $USERNAME:$USERNAME $HOME_PATH/.config/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml 2>/dev/null
	check "Configurando iconos en el sistema"
	gtk-update-icon-cache $HOME_PATH/.local/share/icons/Sweet-Rainbow > /dev/null 2>&1 && gtk-update-icon-cache $HOME_PATH/.local/share/icons/candy-icons > /dev/null 2>&1
	check "Actualizando iconos"
	cp $FILES_PATH/xfce4/xfwm4.xml $HOME_PATH/.config/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml > /dev/null 2>&1
	chown -R $USERNAME:$USERNAME $HOME_PATH/.config/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml 2>/dev/null
	check "Configurando paneles de trabajo"
	mkdir $HOME_PATH/.config/scripts && chown -R $USERNAME:$USERNAME $HOME_PATH/.config/scripts/ 2>/dev/null
	check "Configurando directorio de scripts para la barra de tarea"
	cp $FILES_PATH/scripts/ethstatus.sh $HOME_PATH/.config/scripts/ethstatus.sh > /dev/null 2>&1
	chmod 774 $HOME_PATH/.config/scripts/ethstatus.sh 2>/dev/null
	chown -R $USERNAME:$USERNAME $HOME_PATH/.config/scripts/ethstatus.sh 2>/dev/null
	check "Copiando script eth"
	cp $FILES_PATH/panel/genmon-4.rc $HOME_PATH/.config/xfce4/panel/genmon-4.rc > /dev/null 2>&1
	chown -R $USERNAME:$USERNAME $HOME_PATH/.config/xfce4/panel/genmon-4.rc 2>/dev/null
	check "Configurando info red en barra de tarea"
	cp $FILES_PATH/scripts/vpnstatus.sh $HOME_PATH/.config/scripts/vpnstatus.sh > /dev/null 2>&1
	chmod 774 $HOME_PATH/.config/scripts/vpnstatus.sh 2>/dev/null
	chown -R $USERNAME:$USERNAME $HOME_PATH/.config/scripts/vpnstatus.sh 2>/dev/null
	check "Copiando script vpn"
	cp $FILES_PATH/panel/genmon-5.rc $HOME_PATH/.config/xfce4/panel/genmon-5.rc > /dev/null 2>&1
	chown -R $USERNAME:$USERNAME $HOME_PATH/.config/xfce4/panel/genmon-5.rc 2>/dev/null
	check "Configurando info VPN en barra de tarea"
	cp $FILES_PATH/scripts/wifistatus.sh $HOME_PATH/.config/scripts/wifistatus.sh > /dev/null 2>&1
	chmod 774 $HOME_PATH/.config/scripts/wifistatus.sh 2>/dev/null
	chown -R $USERNAME:$USERNAME $HOME_PATH/.config/scripts/wifistatus.sh 2>/dev/null
	check "Copiando script wifi"
	cp $FILES_PATH/panel/genmon-24.rc $HOME_PATH/.config/xfce4/panel/genmon-24.rc > /dev/null 2>&1
	chown -R $USERNAME:$USERNAME $HOME_PATH/.config/xfce4/panel/genmon-24.rc 2>/dev/null
	check "Configurando info Wifi en barra de tarea"
	cp $FILES_PATH/panel/genmon-35.rc $HOME_PATH/.config/xfce4/panel/genmon-35.rc > /dev/null 2>&1
	chown -R $USERNAME:$USERNAME $HOME_PATH/.config/xfce4/panel/genmon-35.rc 2>/dev/null
	check "Configurando info de uso de memoria ram"
	cp $FILES_PATH/scripts/ramstatus.sh $HOME_PATH/.config/scripts/ramstatus.sh > /dev/null 2>&1
	chmod 774 $HOME_PATH/.config/scripts/ramstatus.sh 2>/dev/null
	chown -R $USERNAME:$USERNAME $HOME_PATH/.config/scripts/ramstatus.sh 2>/dev/null
	check "Copiando script de uso de memoria ram"
	cp $FILES_PATH/panel/genmon-37.rc $HOME_PATH/.config/xfce4/panel/genmon-37.rc > /dev/null 2>&1
	chown -R $USERNAME:$USERNAME $HOME_PATH/.config/xfce4/panel/genmon-37.rc 2>/dev/null
	check "Configurando info de uso de cpu"
	cp $FILES_PATH/scripts/cpustatus.sh $HOME_PATH/.config/scripts/cpustatus.sh > /dev/null 2>&1
	chmod 774 $HOME_PATH/.config/scripts/cpustatus.sh 2>/dev/null
	chown -R $USERNAME:$USERNAME $HOME_PATH/.config/scripts/cpustatus.sh 2>/dev/null
	check "Copiando script de uso de cpu"
	cp $FILES_PATH/scripts/whichSystem /usr/local/bin/whichSystem > /dev/null 2>&1
	chmod +x /usr/local/bin/whichSystem 2>/dev/null
	check "Copiando script whichSystem"
	cd $HOME_PATH/.config/scripts 2>/dev/null
	echo "#!/bin/bash" > user.sh 2>/dev/null
	echo "VAR=$USERNAME" >> user.sh 2>/dev/null
	echo "ICON=(   )" >> user.sh 2>/dev/null
	echo 'ELEC=$(( $RANDOM % 4 ))' >> user.sh 2>/dev/null
	echo 'echo -n ${ICON[$ELEC]} ${VAR:0:1} | tr "[:lower:]" "[:upper:]"; echo ${VAR:1} | tr "[:upper:]" "[:lower:]"' >> user.sh 2>/dev/null
	chown $USERNAME:$USERNAME user.sh && chmod 774 user.sh 2>/dev/null
	check "Configurando script de usuario en barra de tarea"
	cp $FILES_PATH/panel/genmon-29.rc $HOME_PATH/.config/xfce4/panel/genmon-29.rc > /dev/null 2>&1
	chown -R $USERNAME:$USERNAME $HOME_PATH/.config/xfce4/panel/genmon-29.rc 2>/dev/null
	check "Configurando usuario en barra de tarea"
	cp $FILES_PATH/scripts/targetstatus.sh $HOME_PATH/.config/scripts/targetstatus.sh > /dev/null 2>&1
	chmod 774 $HOME_PATH/.config/scripts/targetstatus.sh 2>/dev/null
	chown -R $USERNAME:$USERNAME $HOME_PATH/.config/scripts/targetstatus.sh 2>/dev/null
	touch $HOME_PATH/.config/scripts/.targets && chown $USERNAME:$USERNAME $HOME_PATH/.config/scripts/.targets 2>/dev/null
	check "Copiando script targets"
	cp $FILES_PATH/panel/genmon-31.rc $HOME_PATH/.config/xfce4/panel/genmon-31.rc > /dev/null 2>&1
	chown -R $USERNAME:$USERNAME $HOME_PATH/.config/xfce4/panel/genmon-31.rc 2>/dev/null
	check "Configurando info Target en barra de tarea"
	cp $FILES_PATH/panel/battery-19.rc $HOME_PATH/.config/xfce4/panel/battery-19.rc > /dev/null 2>&1
	chown -R $USERNAME:$USERNAME $HOME_PATH/.config/xfce4/panel/battery-19.rc 2>/dev/null
	check "Configurando icono bateria en barra de tarea"
	cp $FILES_PATH/panel/whiskermenu-1.rc $HOME_PATH/.config/xfce4/panel/whiskermenu-1.rc > /dev/null 2>&1
	chown -R $USERNAME:$USERNAME $HOME_PATH/.config/xfce4/panel/whiskermenu-1.rc 2>/dev/null
	check "Configurando opciones en menu de inicio"
	cp $FILES_PATH/xfce4/helpers.rc $HOME_PATH/.config/xfce4/helpers.rc > /dev/null 2>&1
	chown $USERNAME:$USERNAME $HOME_PATH/.config/xfce4/helpers.rc 2>/dev/null
	check "Configurando aplicativos por default"

	info "Configuracion de notificaciones"
	sudo apt remove xfce4-notifyd -y > /dev/null 2>&1
	cd /tmp/ && wget https://raw.githubusercontent.com/dunst-project/dunst/master/dunstrc > /dev/null 2>&1
	mkdir -p $HOME_PATH/.config/dunst  2>/dev/null
	mv /tmp/dunstrc  $HOME_PATH/.config/dunst/ && chown -R $USERNAME:$USERNAME $HOME_PATH/.config/dunst > /dev/null 2>&1
	check "Notificaciones personalizadas"

	info "Configurar smb.conf"
	cat /etc/samba/smb.conf | sed 's/\[global\]/\[global\]\n   client min protocol = CORE\n   client max protocol = SMB3\n''/' > /tmp/fix_smbconf.tmp 2> /dev/null
	cat /tmp/fix_smbconf.tmp > /etc/samba/smb.conf
	check "Actualizando smb.conf"

	info "Configurar GRUB"
	cat /etc/default/grub | sed 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet"/GRUB_CMDLINE_LINUX_DEFAULT="quiet mitigations=off"/' > /tmp/fix_grub.tmp 2> /dev/null
	cat /tmp/fix_grub.tmp > /etc/default/grub 2> /dev/null
	update-grub &>/dev/null
	check "Actualizando GRUB"

	info "Configurando SNMP.conf"
	perl -pi -e "s[mibs :][#mibs :]" /etc/snmp/snmp.conf
	check "Actualizando SNMP.conf"

	#info "Actualizacion de MSF"
	#gem update --system > /dev/null 2>&1
	#check "Actualizando gem"
	#cd /usr/share/metasploit-framework && gem install bundler:2.2.5 > /dev/null 2>&1
	#bundle install > /dev/null 2>&1
	#check "Actualizando bundle"

	#info "Corregir errores WPSCan"
	#apt remove wpscan -y &>/dev/null
	#check "Remover wpscan"
	#apt autoremove -y &>/dev/null
	#apt autoclean -y &>/dev/null
	#check "Limpieza apt"
	#apt install wpscan -y &>/dev/null
	#check "Instalando wpscan"

	#info "Corregir wfuzz"
	#apt --purge remove python3-pycurl -y &>/dev/null
	#check "Remover python3-pycurl"
	#apt install libcurl4-openssl-dev libssl-dev -y &>/dev/null
	#check "Instalación de libcurl4-openssl-dev y libssl-dev"
	#pip3 install pycurl wfuzz --break-system-packages &>/dev/null
	#check "Instalando pycurl y wfuzz"
}