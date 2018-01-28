# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/home/angus/.oh-my-zsh

bindkey -v

ZSH_THEME="gentoo"

# enable plugins
plugins=(
git 
vi-mode
colored-man-pages
)

source $ZSH/oh-my-zsh.sh

# User configuration

export EDITOR='vim'
export KEYTIMEOUT=1

# Personal aliases go here
alias wttr="curl -s wttr.in/Liverpool"
alias sl="sl -e"
