# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/home/angus/.oh-my-zsh

bindkey -v

ZSH_THEME="gentoo"

# Enable plugins
plugins=(
git 
history
vi-mode
colored-man-pages
)

source $ZSH/oh-my-zsh.sh

# User configuration

# Use vim to edit commands
export EDITOR='nvim'
export KEYTIMEOUT=1

# Share command history between all open urxvt instances
setopt inc_append_history
setopt share_history

# Personal aliases go here
alias wttr="curl -s wttr.in/Liverpool"
alias sl="sl -e"
alias vim="NVIM_LISTEN_ADDRESS=/tmp/nvimsocket nvim"

