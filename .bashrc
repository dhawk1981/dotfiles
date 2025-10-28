####################################################################################
##		 _               _
##		| |__   __ _ ___| |__    _ __ ___
##		| '_ \ / _` / __| '_ \  | '__/ __|
##		| |_) | (_| \__ \ | | | | | | (__
##		|_.__/ \__,_|___/_| |_| |_|  \___|
##
####################################################################################

####################################################################################
##	Exports
####################################################################################
export HISTCONTROL=ignoreboth:erasedups
export EDITOR=vim
HISTSIZE=2000
HISTFILESIZE=2000

####################################################################################
##	Globals
####################################################################################
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

#export PAGER="nvim +Man!."
#export MANPAGER="nvim +Man!."
#export PAGER="bat"
#export MANPAGER="bat"
export MANPAGER="sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"
#man 2 select
####################################################################################
##	Path
####################################################################################
if ! [[ "$PATH" =~ "$HOME/.bin:$HOME/bin:$HOME/.local/bin" ]]; then
	PATH="$HOME/.bin:$HOME/bin:$HOME/.local/bin:$PATH"
fi
export PATH

####################################################################################
##	Import Sources
####################################################################################
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi
unset rc

####################################################################################
##	Prompt
####################################################################################
PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "

####################################################################################
##	Options
####################################################################################
bind "set completion-ignore-case on"

####################################################################################
##	Alias
####################################################################################
alias ls='ls --color=auto'
alias la='ls -a'
alias ll='ls -alFh'
alias l='ls'
alias l.="ls -A | grep -E '^\.'"
alias cd..='cd ..'
alias pacman='sudo pacman'
alias df='df -h'
alias grep='grep --color=auto'
alias vifm='vifm -f .'
alias update='sudo pacman -Syu'
alias killall='killall -s SIGKILL'
alias cat='bat --paging=never'
alias cl='clear'
alias printenv='clear && printenv | sort | less'
alias hyprcfg="nvim ~/.config/hypr/hyprland.conf"
alias vim="nvim"
alias vi="nvim"
alias v="nvim"
# Alias for downloading a single YouTube video with best quality, concurrent fragments, and 4 threads
alias yt-dlp-video='yt-dlp -f best --concurrent-fragments 4'

# Alias for downloading a YouTube playlist with best quality, concurrent fragments, and 4 threads
alias yt-dlp-playlist='yt-dlp -f best --concurrent-fragments 4'

# Alias for downloading an entire YouTube channel with best quality, concurrent fragments, and 4 threads
alias yt-dlp-channel='yt-dlp -f best --concurrent-fragments 4'

####################################################################################
##	Dot Files Git
####################################################################################
#alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
####################################################################################
##	Functions
####################################################################################

extract() {
	if [ -f $1 ]; then
		case $1 in
		*.tar.bz2) tar xvjf $1 ;;
		*.tar.gz) tar xvzf $1 ;;
		*.bz2) bunzip2 $1 ;;
		*.rar) unrar x $1 ;;
		*.gz) gunzip $1 ;;
		*.tar) tar xvf $1 ;;
		*.tbz2) tar xvjf $1 ;;
		*.tgz) tar xvzf $1 ;;
		*.zip) unzip $1 ;;
		*.Z) uncompress $1 ;;
		*.7z) 7z x $1 ;;
		*) echo "don't know how to extract '$1'..." ;;
		esac
	else
		echo "'$1' is not a valid file!"
	fi
}

resetdock(){
	#	Function to reset docking station because it periodicly
	#	freezes one monitor after sitting a while
	echo "Resetting T6 Usb Docking Staion"
	sudo usbreset "USB Station"
}
####################################################################################
##	Usless
####################################################################################
complete -F _complete_alias dotfiles
source /usr/share/bash-completion/completions/git
__git_complete dotfiles __git_main
#fastfetch
