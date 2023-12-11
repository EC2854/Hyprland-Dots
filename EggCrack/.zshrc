export TERM="xterm-256color"
export EDITOR="nvim"
export VISUAL="nvim"

export MANPAGER="nvim +Man!"

eval "$(starship init zsh)"

neofetch --kitty --source ~/.config/neofetch/nyarch.png

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# Better History Navigation
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots) # Include hidden files.


# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' history-substring-search-down 
bindkey -M menuselect 'k' history-substring-search-up 
bindkey -M menuselect 'l' vi-forward-char
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
    if [[ ${KEYMAP} == vicmd ]] ||
        [[ $1 = 'block' ]]; then
        echo -ne '\e[1 q'
    elif [[ ${KEYMAP} == main ]] ||
        [[ ${KEYMAP} == viins ]] ||
        [[ ${KEYMAP} = '' ]] ||
        [[ $1 = 'beam' ]]; then
        echo -ne '\e[5 q'
    fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use lf to switch directories and bind it to ctrl-o
rangercd () {
    tmp="$(mktemp)"
    ranger --choosedir="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"                                               
    fi
}
bindkey -s '^o' 'rangercd\n'

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

alias vim='nvim'
alias s='sudo'
alias v='nvim'
alias sv='sudo nvim'
alias grep='rg'
alias rg='rg -p'
alias rm='rm -rf'


alias ..='cd ..'
alias .2='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

alias .r='cd /'
alias .h='cd ~'
alias .c='cd ~/.config/'
alias .d='cd ~/Documents/'
alias .D='cd ~/Downloads/'
alias .p='cd ~/Pictures/'
alias .v='cd ~/Videos/'

alias ls='eza --icons=always --color=always --hyperlink --group-directories-first'
alias la='eza --icons=always --color=always --hyperlink --group-directories-first -a'
alias ll='eza --icons=always --color=always --hyperlink --group-directories-first -la --no-time'
alias lt='eza --icons=always --color=always --hyperlink --group-directories-first -T'

alias cat='bat -P --color=always --style=plain --theme=base16 --wrap=auto'
alias ncat='bat -P --color=always --style=numbers --theme=base16 --wrap=auto'
alias icat='kitty +kitten icat --align=left'

alias upd='yay -Syu --noconfirm --quiet'
alias inst='yay -S --noconfirm'
alias uninst='yay -Rns --noconfirm'
alias rem='sudo pacman -Rns $(pacman -Qq | fzf)'
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'
alias cls='clear && fastfetch'

alias tobash="sudo chsh $USER -s /bin/bash && bash"
alias tozsh="sudo chsh $USER -s /bin/zsh && zsh"
alias tofish="sudo chsh $USER -s /bin/fish && fish"

# Toggle Starship Modules
alias toggle_user='starship toggle username'
alias toggle_host='starship toggle hostname'
alias toggle_dir='starship toggle directory'
alias toggle_git='starship toggle git_branch'
alias toggle_duration='starship toggle cmd_duration'

# Silly
alias fucking='sudo'
alias okpa='systemctl poweroff'
alias nekofetch="neofetch --kitty --source ~/.config/neofetch/nyarch.png"

export FZF_DEFAULT_OPTS=" \
--color=bg+:#1e1e2e,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

setopt CORRECT

source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
source ~/.config/zsh/fzf-tab/fzf-tab.zsh
