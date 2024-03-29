##################################################
# antigen stuff
##################################################

source /home/angus/antigen/antigen.zsh

export PATH=$PATH:~/.local/bin
export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket
#export XKB_DEFAULT_OPTIONS=caps:escape

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

# Use vim keybindings
bindkey -v

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

# This changes the cursor to a vertical bar when entering insert mode
zle-keymap-select () {
if [ "$TERM" = "xterm-256color" ]; then
        if [ $KEYMAP = vicmd ]; then
                # the command mode for vi
                echo -ne "\e[2 q"
        else
                # the insert mode for vi
                echo -ne "\e[5 q"
        fi
fi
}

# We start in insert mode, so the cursor should be a bar then too
echo -ne "\e[5 q"

# Use bar cursor for each new prompt, e.g. when exiting a program.
_fix_cursor() {
       echo -ne '\e[5 q'
}
precmd_functions+=(_fix_cursor)

# Use neovim to edit commands
export EDITOR='nvim'
export KEYTIMEOUT=1

# Use neovim as pager for man
export MANPAGER='nvim +Man!'
export MANWIDTH=999

# Use firefox and qutebrowser with native wayland mode
#export MOZ_ENABLE_WAYLAND=1
#export XDG_SESSION_TYPE=wayland
#export XDG_CURRENT_DESKTOP=sway
#export GDK_BACKEND=wayland

# Share command history between all open terminal instances
setopt inc_append_history
setopt share_history

# Personal aliases go here
alias wttr="curl -s wttr.in/Hamburg"
alias sl="sl -e"
alias vim="nvim"
alias gs="git status"
alias et="edittex"
alias wm="sudo wifi-menu"
alias ssha="ssh angus@angus-server.duckdns.org -t 'tmux attach || tmux'"
alias hp="bluetoothctl connect 00:16:94:2B:F0:DC"
alias jbl="bluetoothctl connect 78:44:05:40:29:78"
alias die="disown && exit"
alias sl="sl -e"
alias to="texfile_opener"
alias old="zathura ~/Downloads/`ls -t ~/Downloads | head -1`"
alias lastpdf="zathura Downloads/$(ls -t Downloads | grep .pdf | head -1) & die"
alias hm="systemctl --user status offlineimap-oneshot@hotmail.timer | grep Trigger"
alias hb="systemctl --user status offlineimap-oneshot@hamburg.timer | grep Trigger"
alias tbadd="tbsearch --add-from-arxiv"
alias lo="libreoffice"

# fzf shortcuts
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
