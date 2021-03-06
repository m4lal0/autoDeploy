#!/bin/bash
#by @m4lal0

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

	info "Descargando fuente (Fira Code Nerd)"
	cd /usr/local/share/fonts/ 2>/dev/null
	wget https://github.com/daniruiz/nerd-fonts/raw/fira%2Bkali/patched-fonts/FiraCode/Regular/complete/Fira%20Code%20Regular%20Nerd%20Font%20Complete.ttf > /dev/null 2>&1
	check "Al descargar la fuente FiraCode Nerd"

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
	wget "https://github.com$(curl --silent https://github.com/Peltoche/lsd/releases | grep 'lsd_.*_amd64.deb' | awk -F '\"' '{print $2}' | head -n 1)" -O /tmp/lsd.deb > /dev/null 2>&1
	check "Descargando el release de lsd"
	dpkg -i /tmp/lsd.deb > /dev/null 2>&1
	check "Instalación de lsd"

	info "Instalando bat"
	wget "https://github.com$(curl --silent https://github.com/sharkdp/bat/releases | grep 'bat_.*_amd64.deb' | awk -F '\"' '{print $2}' | head -n 1)" -O /tmp/bat.deb > /dev/null 2>&1
	check "Descargando el release de bat"
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

	info "Estableciendo configuración de vim"
	wget https://raw.githubusercontent.com/arcticicestudio/nord-vim/develop/colors/nord.vim -O /usr/share/vim/vim82/colors/nord.vim > /dev/null 2>&1
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

	info "Configurando rofi"
	mkdir $HOME_PATH/.config/rofi && cd $HOME_PATH/.config/rofi
	wget https://raw.githubusercontent.com/VaughnValle/blue-sky/master/nord.rasi -O /usr/share/rofi/themes/nord.rasi > /dev/null 2>&1
	check "Descargando tema para rofi"
	echo "rofi.theme: /usr/share/rofi/themes/nord.rasi" > config 2>/dev/null
	check "Configurando tema para rofi"
	chmod 644 config > /dev/null 2>&1
	chown -R $USERNAME:$USERNAME $HOME_PATH/.config/rofi 2>/dev/null
	check "Configuracion de rofi ($USERNAME)"
	cd
	if [ -d .config ]; then
		ln -sf $HOME_PATH/.config/rofi /root/.config/rofi 2>/dev/null
		check "Configuracion de rofi (root)"
	else
		mkdir .config && ln -sf $HOME_PATH/.config/rofi /root/.config/rofi 2>/dev/null
		check "Configuracion de rofi (root)"
	fi
	# cd && mkdir .config && ln -sf $HOME_PATH/.config/rofi /root/.config/rofi 2>/dev/null
	# check "Configuracion de rofi (root)"

	info "Configurando mate terminal"
	if [ ! -d /org/mate/terminal/profiles/default ]; then
		mkdir /org/mate/terminal/profiles/default 2> /dev/null
	fi
	sudo -u $USERNAME dconf write /org/mate/terminal/profiles/default/copy-selection 'true' > /dev/null 2>&1
	sudo -u $USERNAME dconf write /org/mate/terminal/profiles/default/background-darkness '0.87130434782608701' > /dev/null 2>&1
	sudo -u $USERNAME dconf write /org/mate/terminal/profiles/default/background-color '#FFFFFFFFDDDD' > /dev/null 2>&1
	sudo -u $USERNAME dconf write /org/mate/terminal/profiles/default/bold-color '#000000000000' > /dev/null 2>&1
	sudo -u $USERNAME dconf write /org/mate/terminal/profiles/default/foreground-color '#000000000000' > /dev/null 2>&1
	sudo -u $USERNAME dconf write /org/mate/terminal/profiles/default/use-system-font 'false' > /dev/null 2>&1
	sudo -u $USERNAME dconf write /org/mate/terminal/profiles/default/font "'Hack Nerd Font Regular 11'" > /dev/null 2>&1
	sudo -u $USERNAME dconf write /org/mate/terminal/profiles/default/background-type "'transparent'" > /dev/null 2>&1
	sudo -u $USERNAME dconf write /org/mate/terminal/profiles/default/silent-bell 'true' > /dev/null 2>&1
	sudo -u $USERNAME dconf write /org/mate/terminal/profiles/default/default-show-menubar 'false' > /dev/null 2>&1
	sudo -u $USERNAME dconf write /org/mate/terminal/profiles/default/cursor-shape "'ibeam'" > /dev/null 2>&1
	sudo -u $USERNAME dconf write /org/mate/terminal/profiles/default/scrollback-unlimited 'true' > /dev/null 2>&1
	check  "Al configurar mate terminal"

	info "Configurando escritorio"
	wget https://gitlab.com/kalilinux/packages/kali-wallpapers/-/raw/kali/master/2020.4/backgrounds/kali/kali-geometric-16x9.png?inline=false -O /usr/share/backgrounds/kali/kali-geometric-16x9.png > /dev/null 2>&1
	wget https://gitlab.com/kalilinux/packages/kali-wallpapers/-/raw/kali/master/2020.4/backgrounds/kali/kali-geometric-16x10.png?inline=false -O /usr/share/backgrounds/kali/kali-geometric-16x10.png > /dev/null 2>&1
	wget https://gitlab.com/kalilinux/packages/kali-wallpapers/-/raw/kali/master/2020.4/backgrounds/kali/kali-light-strips-16x10.png?inline=false -O /usr/share/backgrounds/kali/kali-light-strips-16x10.png > /dev/null 2>&1
	wget https://gitlab.com/kalilinux/packages/kali-wallpapers/-/raw/kali/master/2020.4/backgrounds/kali/kali-light-strips-16x9.png?inline=false -O /usr/share/backgrounds/kali/kali-light-strips-16x9.png > /dev/null 2>&1
	wget https://gitlab.com/kalilinux/packages/kali-wallpapers/-/raw/kali/master/2020.4/backgrounds/kali/kali-contours-16x9.png?inline=false -O /usr/share/backgrounds/kali/kali-contours-16x9.png > /dev/null 2>&1
	wget https://gitlab.com/kalilinux/packages/kali-wallpapers/-/raw/kali/master/2020.4/backgrounds/kali/kali-contours-16x10.png?inline=false -O /usr/share/backgrounds/kali/kali-contours-16x10.png > /dev/null 2>&1
	wget https://gitlab.com/kalilinux/packages/kali-wallpapers/-/raw/kali/master/2021.4/backgrounds/kali/kali-abstract-sky-16x9.png?inline=false -O /usr/share/backgrounds/kali/kali-abstract-sky-16x9.png > /dev/null 2>&1
	wget https://gitlab.com/kalilinux/packages/kali-wallpapers/-/raw/kali/master/legacy/backgrounds/kali-2.0/kali-2.0-1920x1080.png?inline=false -O /usr/share/backgrounds/kali/kali-2.0-1920x1080.png > /dev/null 2>&1
	ln -s /usr/share/backgrounds/kali/kali-geometric-16x9.png /usr/share/backgrounds/kali-16x9/kali-geometric-16x9.png > /dev/null 2>&1
	ln -s /usr/share/backgrounds/kali/kali-light-strips-16x9.png /usr/share/backgrounds/kali-16x9/kali-light-strips-16x9.png > /dev/null 2>&1
	ln -s /usr/share/backgrounds/kali/kali-abstract-sky-16x9.png /usr/share/backgrounds/kali-16x9/kali-abstract-sky-16x9.png > /dev/null 2>&1
	ln -s /usr/share/backgrounds/kali/kali-contours-16x9.png /usr/share/backgrounds/kali-16x9/kali-contours-16x9.png > /dev/null 2>&1
	ln -s /usr/share/backgrounds/kali/kali-2.0-1920x1080.png /usr/share/backgrounds/kali-16x9/kali-2.0-1920x1080.png > /dev/null 2>&1
	check "Al descargar fondos"
	unlink /usr/share/desktop-base/kali-theme/login/background > /dev/null 2>&1
	ln -s /usr/share/backgrounds/kali-16x9/kali-contours-16x9.png /usr/share/desktop-base/kali-theme/login/background > /dev/null 2>&1
	check "Al configurar fondo de inicio de sesión"
	cp $FILES_PATH/xfce4/xfce4-desktop.xml $HOME_PATH/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml > /dev/null 2>&1
	chown -R $USERNAME:$USERNAME $HOME_PATH/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml 2>/dev/null
	check "Al configurar fondo de escritorio"
	cp $FILES_PATH/xfce4/xfce4-keyboard-shortcuts.xml $HOME_PATH/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml > /dev/null 2>&1
	chown -R $USERNAME:$USERNAME $HOME_PATH/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml 2>/dev/null
	check "Al configurar atajos de teclado"
	cp $FILES_PATH/xfce4/thunar.xml $HOME_PATH/.config/xfce4/xfconf/xfce-perchannel-xml/thunar.xml > /dev/null 2>&1
	chown -R $USERNAME:$USERNAME $HOME_PATH/.config/xfce4/xfconf/xfce-perchannel-xml/thunar.xml 2>/dev/null
	check "Al configurar ventanas"
	cp $FILES_PATH/xfce4/xfce4-panel.xml $HOME_PATH/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml > /dev/null 2>&1
	chown -R $USERNAME:$USERNAME $HOME_PATH/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml 2>/dev/null
	check "Al configurar barra de tarea"
	cp $FILES_PATH/xfce4/xfwm4.xml $HOME_PATH/.config/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml > /dev/null 2>&1
	chown -R $USERNAME:$USERNAME $HOME_PATH/.config/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml 2>/dev/null
	check "Al configurar paneles de trabajo"
	cd $FILES_PATH/xfce4 2>/dev/null
	tar -xJf Sweet-Rainbow.tar.xz && tar -xJf candy-icons.tar.xz > /dev/null 2>&1
	mkdir $HOME_PATH/.local/share/icons && mv $FILES_PATH/xfce4/Sweet-Rainbow $FILES_PATH/xfce4/candy-icons $HOME_PATH/.local/share/icons > /dev/null 2>&1
	chown -R $USERNAME:$USERNAME $HOME_PATH/.local/share/icons 2>/dev/null
	check  "Al descargar iconos ($USERNAME)"
	mkdir -p /root/.local/share && ln -s $HOME_PATH/.local/share/icons /root/.local/share/icons 2>/dev/null
	check "Al descargar iconos (root)"
	cp $FILES_PATH/xfce4/xsettings.xml $HOME_PATH/.config/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml > /dev/null 2>&1
	chown -R $USERNAME:$USERNAME $HOME_PATH/.config/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml 2>/dev/null
	check "Al configurar iconos en el sistema"
	gtk-update-icon-cache $HOME_PATH/.local/share/icons/Sweet-Rainbow > /dev/null 2>&1 && gtk-update-icon-cache $HOME_PATH/.local/share/icons/candy-icons > /dev/null 2>&1
	check "Al actualizar iconos"
	cp $FILES_PATH/xfce4/xfwm4.xml $HOME_PATH/.config/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml > /dev/null 2>&1
	chown -R $USERNAME:$USERNAME $HOME_PATH/.config/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml 2>/dev/null
	check "Al configurar paneles de trabajo"
	mkdir $HOME_PATH/.config/scripts && chown -R $USERNAME:$USERNAME $HOME_PATH/.config/scripts/ 2>/dev/null
	check "Configurando directorio de scripts para la barra de tarea"
	cp $FILES_PATH/scripts/ethstatus.sh $HOME_PATH/.config/scripts/ethstatus.sh > /dev/null 2>&1
	chmod 774 $HOME_PATH/.config/scripts/ethstatus.sh 2>/dev/null
	chown -R $USERNAME:$USERNAME $HOME_PATH/.config/scripts/ethstatus.sh 2>/dev/null
	check "Al copiar script eth"
	cp $FILES_PATH/panel/genmon-4.rc $HOME_PATH/.config/xfce4/panel/genmon-4.rc > /dev/null 2>&1
	chown -R $USERNAME:$USERNAME $HOME_PATH/.config/xfce4/panel/genmon-4.rc 2>/dev/null
	check "Al configurar info red en barra de tarea"
	cp $FILES_PATH/scripts/vpnstatus.sh $HOME_PATH/.config/scripts/vpnstatus.sh > /dev/null 2>&1
	chmod 774 $HOME_PATH/.config/scripts/vpnstatus.sh 2>/dev/null
	chown -R $USERNAME:$USERNAME $HOME_PATH/.config/scripts/vpnstatus.sh 2>/dev/null
	check "Al copiar script vpn"
	cp $FILES_PATH/panel/genmon-5.rc $HOME_PATH/.config/xfce4/panel/genmon-5.rc > /dev/null 2>&1
	chown -R $USERNAME:$USERNAME $HOME_PATH/.config/xfce4/panel/genmon-5.rc 2>/dev/null
	check "Al configurar info VPN en barra de tarea"
	cp $FILES_PATH/scripts/wifistatus.sh $HOME_PATH/.config/scripts/wifistatus.sh > /dev/null 2>&1
	chmod 774 $HOME_PATH/.config/scripts/wifistatus.sh 2>/dev/null
	chown -R $USERNAME:$USERNAME $HOME_PATH/.config/scripts/wifistatus.sh 2>/dev/null
	check "Al copiar script wifi"
	cp $FILES_PATH/panel/genmon-24.rc $HOME_PATH/.config/xfce4/panel/genmon-24.rc > /dev/null 2>&1
	chown -R $USERNAME:$USERNAME $HOME_PATH/.config/xfce4/panel/genmon-24.rc 2>/dev/null
	check "Al configurar info Wifi en barra de tarea"
	cp $FILES_PATH/scripts/whichSystem /usr/local/bin/whichSystem > /dev/null 2>&1
	chmod +x /usr/local/bin/whichSystem 2>/dev/null
	check "Al copiar script whichSystem"
	cd $HOME_PATH/.config/scripts 2>/dev/null
	echo "#!/bin/bash" > user.sh 2>/dev/null
	echo "VAR=$USERNAME" >> user.sh 2>/dev/null
	echo "ICON=(   )" >> user.sh 2>/dev/null
	echo 'ELEC=$(( $RANDOM % 4 ))' >> user.sh 2>/dev/null
	echo 'echo -n ${ICON[$ELEC]} ${VAR:0:1} | tr "[:lower:]" "[:upper:]"; echo ${VAR:1} | tr "[:upper:]" "[:lower:]"' >> user.sh 2>/dev/null
	chown $USERNAME:$USERNAME user.sh && chmod 774 user.sh 2>/dev/null
	check "Al configurar script de usuario en barra de tarea"
	cp $FILES_PATH/panel/genmon-29.rc $HOME_PATH/.config/xfce4/panel/genmon-29.rc > /dev/null 2>&1
	chown -R $USERNAME:$USERNAME $HOME_PATH/.config/xfce4/panel/genmon-29.rc 2>/dev/null
	check "Al configurar usuario en barra de tarea"
	cp $FILES_PATH/panel/battery-19.rc $HOME_PATH/.config/xfce4/panel/battery-19.rc > /dev/null 2>&1
	chown -R $USERNAME:$USERNAME $HOME_PATH/.config/xfce4/panel/battery-19.rc 2>/dev/null
	check "Al configurar icono bateria en barra de tarea"
	cp $FILES_PATH/panel/whiskermenu-1.rc $HOME_PATH/.config/xfce4/panel/whiskermenu-1.rc > /dev/null 2>&1
	chown -R $USERNAME:$USERNAME $HOME_PATH/.config/xfce4/panel/whiskermenu-1.rc 2>/dev/null
	check "Al configurar opciones en menu de inicio"
	cp $FILES_PATH/xfce4/helpers.rc $HOME_PATH/.config/xfce4/helpers.rc > /dev/null 2>&1
	chown $USERNAME:$USERNAME $HOME_PATH/.config/xfce4/helpers.rc 2>/dev/null
	check "Al configurar aplicativos por default"

	info "Configuracion de notificaciones"
	sudo apt remove xfce4-notifyd -y > /dev/null 2>&1
	cd /tmp/ && wget https://raw.githubusercontent.com/dunst-project/dunst/master/dunstrc > /dev/null 2>&1
	mkdir -p $HOME_PATH/.config/dunst  2>/dev/null
	mv /tmp/dunstrc  $HOME_PATH/.config/dunst/ && chown -R $USERNAME:$USERNAME $HOME_PATH/.config/dunst > /dev/null 2>&1
	check "Notificaciones personalizadas"

	# info "Seleccionando Java 8 como predeterminado"
	# option=$(echo | update-alternatives --config java | grep "java-8" | tr -d '*' | awk '{print $1}')
	# if [ $option ]; then
	# 	echo "$option" | update-alternatives --config java > /dev/null 2>&1
	# 	check "Eligiendo Java 8 como predeterminado"
	# fi
}