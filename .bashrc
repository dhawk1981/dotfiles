####################################################################################
##		 _               _
##		| |__   __ _ ___| |__    _ __ ___
##		| '_ \ / _` / __| '_ \  | '__/ __|
##		| |_) | (_| \__ \ | | | | | | (__
##		|_.__/ \__,_|___/_| |_| |_|  \___|
##
####################################################################################

####################################################################################
## 	Bash Options	
####################################################################################

shopt -s cdspell          # autocorrect cd typos
shopt -s dirspell         # autocorrect dir names in completion
shopt -s autocd           # just type dir name to cd
shopt -s globstar         # ** matches all files and dirs recursively
shopt -s checkwinsize     # update LINES/COLUMNS after each command
shopt -s histappend       # append history
bind "set completion-ignore-case on"

####################################################################################
##	Exports
####################################################################################

export EDITOR=vim
export HISTSIZE=-1
export HISTFILESIZE=-1
export HISTCONTROL=ignoredups:ignorespace:erasedups
PROMPT_COMMAND='history -a; history -c; history -r'
# Color Man Pages
export MANPAGER="sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"

####################################################################################
##	Globals
####################################################################################

if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

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
##  Prompt – clean base + FAST, SAFE git branch
####################################################################################

PS1='\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[35m\]$( \
    git rev-parse --is-inside-work-tree >/dev/null 2>&1 && \
    ( git symbolic-ref --quiet --short HEAD 2>/dev/null || \
      git rev-parse --short HEAD 2>/dev/null ) | \
    sed "s/^/ (/; s/$/)/" \
)\[\033[m\]\$ '

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
alias cls='clear'
alias printenv='clear && printenv | sort | less'
alias vim="nvim" 
alias vi="nvim"
alias v="nvim"
alias reboot='sudo reboot'
alias poweroff='sudo poweroff'
alias sctl='sudo systemctl'

# cd shortcuts 
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Safer rm with trash-cli (optional — uncomment if installed)
# command -v trash-put >/dev/null && {
#     alias rm='trash-put'
#     alias rl='trash-list'
#     alias rr='trash-restore'
#     alias re='trash-empty'
#     alias rmd='command rm -d'
#     alias rmf='command rm -f'
#     alias rmr='command rm -r'
# }

####################################################################################
## Ctrl+R: fuzzy history search Ctrl+T: fuzzy file search
####################################################################################

[ -f /usr/share/fzf/key-bindings.bash ] && source /usr/share/fzf/key-bindings.bash
[ -f /usr/share/fzf/completion.bash ] && source /usr/share/fzf/completion.bash

####################################################################################
##	GIT Setup for tracking dotfiles with bash completions
####################################################################################

alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
complete -F _complete_alias dotfiles
source /usr/share/bash-completion/completions/git 2>/dev/null || true
__git_complete dotfiles __git_main 2>/dev/null || true

####################################################################################
##	Usefull Functions
####################################################################################

extract() {
	if [ -f "$1" ]; then
		case "$1" in
		*.tar.bz2) tar xvjf "$1" ;;
		*.tar.gz) tar xvzf "$1" ;;
		*.bz2) bunzip2 "$1" ;;
		*.rar) unrar x "$1" ;;
		*.gz) gunzip "$1" ;;
		*.tar) tar xvf "$1" ;;
		*.tbz2) tar xvjf "$1" ;;
		*.tgz) tar xvzf "$1" ;;
		*.zip) unzip "$1" ;;
		*.Z) uncompress "$1" ;;
		*.7z) 7z x "$1" ;;
		*) echo "don't know how to extract '$1'..." ;;
		esac
	else
		echo "'$1' is not a valid file!"
	fi
}

# Reset docking station
resetdock(){
	echo "Resetting T6 Usb Docking Staion"
	sudo usbreset "USB Station"
}

# cd into dir and list contents
cdls() { cd "$@" && ll; }

# Make cd ->
mkcd() { mkdir -p "$1" && cd "$1"; }

# Weather
weather() { curl -s "wttr.in/${1:-}?m" | head -n 38; }

# Repeat last command with sudo
please() { sudo "$(fc -ln -1 | head -n1)"; }

# Pretty path
path() { echo "$PATH" | tr ':' '\n' | nl; }

#Reload bashrc.d
relod() {
    for rc in ~/.bashrc.d; do
        source "$rc"
    done
    echo "bashrc.d reloaded."
}

####################################################################################
## 	Youtube-DLP	
####################################################################################

yt-dlp-best() {
  yt-dlp -f 'bestvideo+bestaudio/best' --concurrent-fragments "${1:-4}" "${@:2}"
}
alias yt-dlp-video='yt-dlp-best 4'
alias yt-dlp-playlist='yt-dlp-best 8 -i'
alias yt-dlp-channel='yt-dlp-best 8 -i --yes-playlist'

####################################################################################
## 	Sudo completion for common commands
####################################################################################

# Load systemctl completion
[[ $(type -t _systemctl) == function ]] || source /usr/share/bash-completion/completions/systemctl 2>/dev/null

# Fix all alias completions
complete -F _pacman    pacman
complete -F _systemctl sctl
complete -F _command   reboot
complete -F _command   poweroff
complete -F _pacman    "sudo pacman"
complete -F _systemctl "sudo sctl"
complete -F _command   "sudo reboot"
complete -F _command   "sudo poweroff"
