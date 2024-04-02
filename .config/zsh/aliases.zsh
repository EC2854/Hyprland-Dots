# aliases for zsh and bash
# this file in sourced in .zshrc and .bashrc

# misc
alias vim='nvim'
alias v='nvim'
alias s='sudo'
alias rg='rg -p' 
alias cls='clear'
alias rm='rm -rf' # I know im a psychopath

# Faster movement

alias ..='cd ..'
alias .2='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

alias gr='cd /'
alias gh='cd ~'
alias gc='cd ~/.config/'
alias gd='cd ~/Documents/'
alias gD='cd ~/Downloads/'
alias gp='cd ~/Pictures/'
alias gv='cd ~/Videos/'

# Even faster movement
alias f='cd "$(find . -maxdepth 5 -type d -print | fzf)"'
alias gf='cd "$(find ~ -maxdepth 5 -type d -print | fzf)"'

# Replacing ls with eza
alias l='eza --icons=always --color=always --hyperlink --group-directories-first'
alias la='eza --icons=always --color=always --hyperlink --group-directories-first -a'
alias ll='eza --icons=always --color=always --hyperlink --group-directories-first -la --no-time'
alias lt='eza --icons=always --color=always --hyperlink --group-directories-first -T'

# Replacing cat with bat and kitty's image preview
alias c='bat -P --color=always --style=plain --theme=base16 --wrap=auto'
alias icat='kitty +kitten icat --align=left'

# Package Managment
alias upd='paru -Syu --noconfirm --quiet'
alias inst='paru -S --noconfirm'
alias uninst='paru -Rns --noconfirm'
alias rem='sudo pacman -Rns $(pacman -Qq | fzf)'
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'

# Change Shells
alias tobash="sudo chsh $USER -s /bin/bash && bash"
alias tozsh="sudo chsh $USER -s /bin/zsh && zsh"
alias tofish="sudo chsh $USER -s /bin/fish && fish"

# Toggle Starship Modules
alias toggle-user='starship toggle username'
alias toggle-host='starship toggle hostname'
alias toggle-dir='starship toggle directory'
alias toggle-git='starship toggle git_branch'
alias toggle-duration='starship toggle cmd_duration'


alias commit='git add . && git commit -m $1'
alias push='git push -u origin main'

# Run Amberol
alias amb="nohup amberol . > /dev/null 2>&1 &"

# Silly
alias fucking='sudo'
alias okpa='systemctl poweroff'
alias nekofetch="neofetch --kitty  ~/.config/neofetch/nyarch.png"
alias susefetch="neofetch --kitty  ~/Pictures/gigaroman.png"
alias shork="~/blahaj/display3d ~/blahaj/blahaj.obj -t 0,0,6"
