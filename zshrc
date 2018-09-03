##################################################
# antigen stuff
##################################################

source /home/angus/antigen/antigen.zsh

export PATH=$PATH:~/.local/bin
export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket

# Use vim keybindings
bindkey -v

# Enable plugins
antigen use oh-my-zsh
antigen bundle git 
antigen bundle history
antigen bundle vi-mode
antigen bundle colored-man-pages
antigen bundle zsh-vimode-visual
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions

# A good-looking, understated theme
antigen theme gentoo

antigen apply
##################################################
# User configuration
##################################################

# Use neovim to edit commands
export EDITOR='nvim'
export KEYTIMEOUT=1

# Share command history between all open terminal instances
setopt inc_append_history
setopt share_history

# Personal aliases go here
alias wttr="curl -s wttr.in/Liverpool"
alias sl="sl -e"
alias okular="zathura"
alias vim="nvim"
alias rmsock="rm -r /tmp/vim/ tmp/vim*"
alias gs="git status"
alias sps="sudo pacman -S"
alias syu="sudo pacman -Syu"
alias et="edittex"
alias wm="sudo wifi-menu"
alias ssha="ssh angus@angus-server.duckdns.org -t 'tmux attach || tmux'"

# Enable visual mode
bindkey -M vicmd v visual-mode
bindkey -M vicmd V edit-command-line

# Enable more vim-style text objects, i.e. ci", ci}, etc.
autoload -U select-bracketed
autoload -U select-quoted
zle -N select-quoted
zle -N select-bracketed
for km in visual viopp; do
    bindkey -M $km -- '-' vi-up-line-or-history
    for c in {a,i}${(s..)^:-\'\"\`\|,./:;-=+@}; do
        bindkey -M $km $c select-quoted
    done
    for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
        bindkey -M $km $c select-bracketed
    done
done
