# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/home/angus/.oh-my-zsh
export PATH=$PATH:~/.local/bin
export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket

bindkey -v

ZSH_THEME="gentoo"

# Enable plugins
plugins=(
git 
history
vi-mode
colored-man-pages
zsh-vimode-visual
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
alias okular="zathura"
alias vim="nvim"
alias rmsock="rm -r /tmp/vim/ tmp/vim*"
alias gs="git status"

# Function to update pathogen plugins
function update_pathogen() {
        cd ~/.vim/bundle/
        for i in `ls`; do
                cd "$i"
                echo ""
                echo "Updating $i"
                git pull
                cd ..
        done
}

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
