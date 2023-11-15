set fish_greeting
set TERM "xterm-256color"
set EDITOR "nvim"
set VISUAL "emacsclient -cn"

set -x MANPAGER "nvim +Man!"

if status is-interactive
    fastfetch
end

alias vim='nvim'
alias grep='rg -p'
alias rg='rg -p'
alias rm='rm -rf'

alias icat='kitty +kitten icat --align=left'

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

alias upd='yay -Syu --noconfirm'
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
alias nekofetch="neofetch --ascii ~/.config/fastfetch/nyarch-big.txt"

starship init fish | source
