# ~/.zshrc file for zsh non-login shells.
# see /usr/share/doc/zsh/examples/zshrc for examples

setopt autocd              # change directory just by typing its name
#setopt correct            # auto correct mistakes
setopt interactivecomments # allow comments in interactive mode
setopt ksharrays           # arrays start at 0
setopt magicequalsubst     # enable filename expansion for arguments of the form ‘anything=expression’
setopt nonomatch           # hide error message if there is no match for the pattern
setopt notify              # report the status of background jobs immediately
setopt numericglobsort     # sort filenames numerically when it makes sense
setopt promptsubst         # enable command substitution in prompt

WORDCHARS=${WORDCHARS//\/} # Don't consider certain characters part of the word

# Manual PATH configuration
GOPATH=/root/go
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/usr/local/games:/usr/games:/snap/bin:/usr/lib/go:$GOPATH/bin

# hide EOL sign ('%')
export PROMPT_EOL_MARK=""

# configure key keybindings
bindkey -e                                        # emacs key bindings
bindkey ' ' magic-space                           # do history expansion on space
bindkey '^[[3;5~' kill-word                       # ctrl + Supr
bindkey '^[[1;5C' forward-word                    # ctrl + ->
bindkey '^[[C' forward-word                       # ctrl + ->
bindkey '^[[1;5D' backward-word                   # ctrl + <-
bindkey '^[[D' backward-word                      # ctrl + <-
bindkey '^[[5~' beginning-of-buffer-or-history    # page up
bindkey '^[[6~' end-of-buffer-or-history          # page down
bindkey '^[[Z' undo                               # shift + tab undo last action

# enable completion features
autoload -Uz compinit
compinit -d ~/.cache/zcompdump
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # case insensitive tab completion

# History configurations
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
#setopt share_history         # share command history data
setopt histignorealldups sharehistory

# force zsh to show the complete history
alias history="history 0"

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PROMPT=$'%F{%(#.blue.green)}┌──${debian_chroot:+($debian_chroot)──}(%B%F{%(#.red.blue)}%n%(#.💀.㉿)%m%b%F{%(#.blue.green)})-[%B%F{reset}%(6~.%-1~/…/%4~.%5~)%b%F{%(#.blue.green)}]\n└─%B%(#.%F{red}#.%F{blue}$)%b%F{reset} '
    RPROMPT=$'%(?.. %? %F{red}%B⨯%b%F{reset})%(1j. %j %F{yellow}%B⚙%b%F{reset}.)'

    # enable syntax-highlighting
    if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && [ "$color_prompt" = yes ]; then
	# ksharrays breaks the plugin. This is fixed now but let's disable it in the
	# meantime.
	# https://github.com/zsh-users/zsh-syntax-highlighting/pull/689
	unsetopt ksharrays
	. /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
	ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
	ZSH_HIGHLIGHT_STYLES[default]=none
	ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=red,bold
	ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=cyan,bold
	ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=green,underline
	ZSH_HIGHLIGHT_STYLES[global-alias]=fg=magenta
	ZSH_HIGHLIGHT_STYLES[precommand]=fg=green,underline
	ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=blue,bold
	ZSH_HIGHLIGHT_STYLES[autodirectory]=fg=green,underline
	ZSH_HIGHLIGHT_STYLES[path]=underline
	ZSH_HIGHLIGHT_STYLES[path_pathseparator]=
	ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]=
	ZSH_HIGHLIGHT_STYLES[globbing]=fg=blue,bold
	ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=blue,bold
	ZSH_HIGHLIGHT_STYLES[command-substitution]=none
	ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]=fg=magenta
	ZSH_HIGHLIGHT_STYLES[process-substitution]=none
	ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]=fg=magenta
	ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=magenta
	ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=magenta
	ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
	ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]=fg=blue,bold
	ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=yellow
	ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=yellow
	ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]=fg=yellow
	ZSH_HIGHLIGHT_STYLES[rc-quote]=fg=magenta
	ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=magenta
	ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=magenta
	ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]=fg=magenta
	ZSH_HIGHLIGHT_STYLES[assign]=none
	ZSH_HIGHLIGHT_STYLES[redirection]=fg=blue,bold
	ZSH_HIGHLIGHT_STYLES[comment]=fg=black,bold
	ZSH_HIGHLIGHT_STYLES[named-fd]=none
	ZSH_HIGHLIGHT_STYLES[numeric-fd]=none
	ZSH_HIGHLIGHT_STYLES[arg0]=fg=green
	ZSH_HIGHLIGHT_STYLES[bracket-error]=fg=red,bold
	ZSH_HIGHLIGHT_STYLES[bracket-level-1]=fg=blue,bold
	ZSH_HIGHLIGHT_STYLES[bracket-level-2]=fg=green,bold
	ZSH_HIGHLIGHT_STYLES[bracket-level-3]=fg=magenta,bold
	ZSH_HIGHLIGHT_STYLES[bracket-level-4]=fg=yellow,bold
	ZSH_HIGHLIGHT_STYLES[bracket-level-5]=fg=cyan,bold
	ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]=standout
    fi
else
    PROMPT='${debian_chroot:+($debian_chroot)}%n@%m:%~%# '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    TERM_TITLE='\e]0;${debian_chroot:+($debian_chroot)}%n@%m: %~\a'
    ;;
*)
    ;;
esac

new_line_before_prompt=yes
precmd() {
    # Print the previously configured title
    print -Pn "$TERM_TITLE"

    # Print a new line before the prompt, but only if it is not the first line
    if [ "$new_line_before_prompt" = yes ]; then
	if [ -z "$_NEW_LINE_BEFORE_PROMPT" ]; then
	    _NEW_LINE_BEFORE_PROMPT=1
	else
	    print ""
	fi
    fi
}

# enable color support of ls, less and man, and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='lsd --group-dirs=first'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias diff='diff --color=auto'
    alias ip='ip --color=auto'

    export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
    export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
    export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
    export LESS_TERMCAP_so=$'\E[01;33m'    # begin reverse video
    export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
    export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
    export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

    # Take advantage of $LS_COLORS for completion as well
    zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
fi

# some more aliases
alias ll='lsd -lha --group-dirs=first'
alias la='lsd -a --group-dirs=first'
alias l='lsd --group-dirs=first'
alias ls='lsd --group-dirs=first'
alias tree='lsd --tree'
alias ping='grc ping'
alias ps='grc ps'
alias traceroute='grc traceroute'
alias netstat='grc netstat'
alias nmap='grc nmap'
alias abe='java -jar /opt/Utilities/abe.jar'
alias dud='grc du -d 1 -h'
alias cheat='tldr'
#alias whatweb='/opt/Web/WhatWeb/whatweb'

alias cat='/usr/bin/bat --paging=never --style=plain'
alias catn='/usr/bin/cat'
alias catl='/usr/bin/bat'

alias rm='trash-put'
alias rm-restore='trash-restore'
alias rm-list='trash-list'

alias zshrc='vi $HOME/.zshrc'
alias reload='source $HOME/.zshrc'

alias textup="curl -F 'f:1=@file.ext' ix.io"
alias transfer="curl --upload-file $1 https://transfer.sh/$1"

# Functions

# Encrypt file
function encryptFile(){
	if [[ -n $1 && $# -eq 1 ]]; then
		openssl enc -aes-256-cbc -pbkdf2 -k strongPass <$1 >$1.enc
	else
		echo -e "\n\t\033[0;36m[\033[0;33m!\033[0;36m] \033[0;37mUse: $0 \033[3;37m<file>\033[0m"
	fi
}

# Decrypt file
function decryptFile(){
	if [[ -n $1 && -n $2 && $# -le 2 ]]; then
		openssl enc -d -aes-256-cbc -pbkdf2 -k strongPass <$1 >$2
	else
		echo -e "\n\t\033[0;36m[\033[0;33m!\033[0;36m] \033[0;37mUse: $0 \033[3;37m<Encrypt-File> <Output-File>\033[0m"
	fi
}

function mkt() {
	mkdir -p {recon,exploits,content} && ls -lah
}

# Search Wordlists
function wordlists(){
	if [[ -n $1 && $# -eq 1 ]]; then
		find -L /usr/share/wordlists -type f -iname "*$1*"
	else
		echo -e "\n\t\033[0;36m[\033[0;33m!\033[0;36m] \033[0;37mUse: $0 \033[3;37m<string>\033[0m"
	fi
}

function extractPorts(){
	if [[ -n $1 && -z $2 ]]; then
		ip_address="$(/usr/bin/cat $1 | grep -oP '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}' | sort -u | head -n 1)"
		ports="$(/usr/bin/cat $1 | grep -oP '\d{1,5}/open' | awk '{print $1}' FS='/' | xargs | tr ' ' ',')"
		ports_list="$(/usr/bin/cat $1 | grep -v ^#| sed 's/Ports: /\'$'\n/g' |  tr '/' '\t' | tr ',' '\n' | sed 's/^ //g' | grep -v "Host" | sed 's/Ignored State.*$//')"
		echo -e "\n\033[0;36m[\033[0;33m!\033[0;36m] \033[3;37mExtracting information...\033[0m" > extractPorts.tmp
		echo -e "\n\t\033[0;36m[\033[0;32m+\033[0;36m] \033[0;37mIP Address: \033[0;35m$ip_address\033[0m" >> extractPorts.tmp
		echo -e "\n\t\033[0;36m[\033[0;32m+\033[0;36m] \033[0;37mOpen Ports: \033[0;33m$ports\033[0m" >> extractPorts.tmp
		echo -e "\n\033[0;36m[\033[0;34m*\033[0;36m] \033[0;37mPorts & Services: \033[0m" >> extractPorts.tmp
		echo -e "\n$ports_list" >> extractPorts.tmp
		echo $ports | tr -d '\n' | xclip -sel clip
		echo -e "\n\033[0;36m[\033[0;33m!\033[0;36m] \033[1;37mPorts copied to clipboard\n\033[0m" >> extractPorts.tmp
		/usr/bin/cat extractPorts.tmp; rm extractPorts.tmp
	elif [[ -n $1 && -n $2 ]]; then
		ports="$(/usr/bin/cat $1 | grep "$2" | sort -u | head -n 1 | grep -oP '\d{1,5}/open' | awk '{print $1}' FS='/' | xargs | tr ' ' ',')"
		ports_list="$(grep -w "$2" $1 | grep -v ^# | sed 's/Ports: /\'$'\n/g' |  tr '/' '\t' | tr ',' '\n' | sed 's/^ //g' | grep -v "Host" | sed 's/Ignored State.*$//')"
		echo -e "\n\033[0;36m[\033[0;33m!\033[0;36m] \033[3;37mExtracting information...\033[0m" > extractPorts.tmp
		echo -e "\n\t\033[0;36m[\033[0;32m+\033[0;36m] \033[0;37mIP Address: \033[0;35m$2\033[0m" >> extractPorts.tmp
		echo -e "\n\t\033[0;36m[\033[0;32m+\033[0;36m] \033[0;37mOpen Ports: \033[0;33m$ports\033[0m" >> extractPorts.tmp
		echo -e "\n\033[0;36m[\033[0;34m*\033[0;36m] \033[0;37mPorts & Services: \033[0m" >> extractPorts.tmp
		echo -e "\n$ports_list" >> extractPorts.tmp
		echo $ports | tr -d '\n' | xclip -sel clip
		echo -e "\n\033[0;36m[\033[0;33m!\033[0;36m] \033[1;37mPorts copied to clipboard\n\033[0m" >> extractPorts.tmp
		/usr/bin/cat extractPorts.tmp; rm extractPorts.tmp
	else
		echo -e "\n\t\033[0;36m[\033[0;33m!\033[0;36m] \033[0;37mUse: $0 \033[3;37m<nmap.grepeable>\033[0m"
	fi
}

function rmk() {
	if [[ -n $1 && $# -eq 1 ]]; then
		echo -ne "\n\033[0;36m[\033[1;34m*\033[0;36m] \033[1;37mFile to apply secure deletion: \033[1;32m$1\033[0m "
		echo
		echo -e "\n\033[0;36m[\033[1;33m!\033[0;36m] \033[1;37mPhase [1/2]:\033[0m\n"
		gum confirm "Desea eliminar?" && scrub -p dod $1 && shred -zun 10 -v $1
	else
		echo -e "\n\t\033[0;36m[\033[0;33m!\033[0;36m] \033[0;37mUse: $0 \033[3;37m<file>\033[0m"
	fi
}

function man() {
    env \
    LESS_TERMCAP_mb=$'\e[01;34m' \
    LESS_TERMCAP_md=$'\e[01;34m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    man "$@"
}

# fzf improvement
function fzf-lovely(){
	if [ "$1" = "h" ]; then
		fzf -m --reverse --preview-window down:20 --preview '[[ $(file --mime {}) =~ binary ]] &&
			echo {} is a binary file ||
			(bat --style=numbers --color=always {} ||
			highlight -O ansi -l {} ||
			coderay {} ||
			rougify {} ||
			/usr/bin/cat {}) 2> /dev/null | head -500'
	else
		fzf -m --preview '[[ $(file --mime {}) =~ binary ]] &&
			echo {} is a binary file ||
			(bat --style=numbers --color=always {} ||
			highlight -O ansi -l {} ||
			coderay {} ||
			rougify {} ||
			/usr/bin/cat {}) 2> /dev/null | head -500'
	fi
}

# Search NSE script
function nseSearch(){
	#locate *.nse | grep -i -o "$1".*;
	if [[ -n $1 && $# -eq 1 ]]; then
		nmap_basepath=$(nmap -v -d 2>/dev/null | grep -Po 'Read from \K\/.*(?=:)')
		script_list=$(grep -Po '[\w-]+(?=.nse)' "$nmap_basepath"/scripts/script.db | grep -i "$1")

		# Search NSE script names for search parameter
		if [[ -n $script_list ]]; then
			echo -e "\n\033[3;36mNSE scripts available in nmap:\033[0m"
			grep -Po '[\w-]+(?=.nse)' "$nmap_basepath"/scripts/script.db | grep -i "$1"
		else
			echo -e "\n\033[1;31mNo matches found for \033[0;97m'$1'\033[1;31m.\033[0m"
		fi
	else
		echo -e "\n\t\033[0;36m[\033[0;33m!\033[0;36m] \033[0;37mUse: $0 \033[3;37m<string>\033[0m"
	fi
}

# Add target
function addtarget(){
	if [[ -n $1 ]]; then
		echo $1 > /home/$SUDO_USER/.config/scripts/.targets 2>/dev/null
	else
		echo -e "\n\t\033[0;36m[\033[0;33m!\033[0;36m] \033[0;37mUse: addtarget <IP-Address>\033[0m"
	fi
}

# Delete target
function deltarget(){
	echo "" > /home/$SUDO_USER/.config/scripts/.targets 2>/dev/null
}

# IP Address Information
function ipinfo(){
	if [[ -n $1 && $# -eq 1 ]]; then
		curl http://ipinfo.io/$1
	else
		echo -e "\n\t\033[0;36m[\033[0;33m!\033[0;36m] \033[0;37mUse: ipinfo <IP-Address>\033[0m"
	fi
}

# My IP Address Public
function myip(){
	curl ifconfig.co
}

# Conocer la URL en una URL acortada
function urlAcortada(){
	if [[ -n $1 && $# -eq 1 ]]; then
		curl -sLI $1 | grep -i Location
	else
		echo -e "\n\t\033[0;36m[\033[0;33m!\033[0;36m] \033[0;37mUse: urlAcortada <URL>\033[0m"
	fi
}

# Conocer la version de WordPress de un sitio
function wpVersion(){
	if [[ -n $1 && $# -eq 1 ]]; then
		curl -s -X GET $1 | grep '<meta name="generator"'
		if [ $? -ne 0 ]; then
			curl -s -X GET $1/wp-links-opml.php | grep '<meta name="generator"'
		fi
	else
		echo -e "\n\t\033[0;36m[\033[0;33m!\033[0;36m] \033[0;37mUse: wpVersion <URL-WordPress>\033[0m"
	fi
}

# Conocer los plugins instalados de un sitio web con WordPress
function wpPlugins(){
	if [[ -n $1 && $# -eq 1 ]]; then
		curl -s -X GET $1 | sed 's/href=/\n/g' | sed 's/src=/\n/g' | grep 'wp-content/plugins/*' | cut -d"'" -f2
	else
		echo -e "\n\t\033[0;36m[\033[0;33m!\033[0;36m] \033[0;37mUse: wpPlugins <URL>\033[0m"
	fi
}

# Conocer los temas instalados de un sitio web con WordPress
function wpThemes(){
	if [[ -n $1 && $# -eq 1 ]]; then
		curl -s -X GET $1 | sed 's/href=/\n/g' | sed 's/src=/\n/g' | grep 'themes' | cut -d"'" -f2
	else
		echo -e "\n\t\033[0;36m[\033[0;33m!\033[0;36m] \033[0;37mUse: wpThemes <URL>\033[0m"
	fi
}

function zoneTransfer(){
	if [[ -n $1 && $# -eq 1 ]]; then
		domain=$1
		n=0
		for server in $(host -t ns $domain | cut -d ' ' -f 4) ; do
			address=`host -l $1 $server | grep -i 'address' | tr "\n" "|"`
				if [ -n "$address" ] ; then
					address2=`echo $address | cut -d '#' -f 1`
					echo $address2
					tmp=`echo $address2 | cut -d ' ' -f 2`
					zonetransfer=`dig +short -t AXFR $domain @$tmp`
					echo -e "\t $zonetransfer"
					n=1
				fi
		done
		if [ $n -eq 0 ] ; then
			echo "\n\t\033[1;31m[-] Zone transfer not possible!\033[0m"
		fi
	else
		echo -e "\n\t\033[0;36m[\033[0;33m!\033[0;36m] \033[0;37mUse: zoneTransfer <DOMAIN>\033[0m"
	fi
}

bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

# Configuration tldr command 
export TLDR_COLOR_NAME="bold yellow"
export TLDR_COLOR_DESCRIPTION="white"
export TLDR_COLOR_EXAMPLE="green"
export TLDR_COLOR_COMMAND="bold cyan"
export TLDR_COLOR_PARAMETER="yellow"
export TLDR_CACHE_ENABLED=1
export TLDR_CACHE_MAX_AGE=720
export TLDR_PAGES_SOURCE_LOCATION="https://raw.githubusercontent.com/tldr-pages/tldr/master/pages"
export TLDR_DOWNLOAD_CACHE_LOCATION="https://tldr-pages.github.io/assets/tldr.zip"

# Fix the Java problem
export _JAVA_AWT_WM_NONREPARENTING=1

# enable auto-suggestions based on the history
if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    . /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    # change suggestion color
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'
fi
source ~/powerlevel10k/powerlevel10k.zsh-theme
source /usr/share/zsh-sudo/sudo.plugin.zsh
#source /usr/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# enable command-not-found
if [ -f /etc/zsh_command_not_found ]; then
	. /etc/zsh_command_not_found
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh