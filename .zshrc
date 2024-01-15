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
lfcd () {
    cd "$(command lf -print-last-dir "$@")"
}
bindkey -s '^o' 'lfcd\n'

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

alias vim='nvim'
alias v='nvim'
alias s='sudo'
alias grep='rg'
alias rg='rg -p' 
alias cls='clear'
alias rm='rm -rf' # I know im a psychopat

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
alias g='cd "$(find . -type d -print | fzf)"'
alias gf='cd "$(find ~ -type d -print | fzf)"'

# Replacing ls with eza
alias ls='eza --icons=always --color=always --hyperlink --group-directories-first'
alias la='eza --icons=always --color=always --hyperlink --group-directories-first -a'
alias ll='eza --icons=always --color=always --hyperlink --group-directories-first -la --no-time'
alias lt='eza --icons=always --color=always --hyperlink --group-directories-first -T'

# Replacing cat with bat and kitty's image preview
alias cat='bat -P --color=always --style=plain --theme=base16 --wrap=auto'
alias ncat='bat -P --color=always --style=numbers --theme=base16 --wrap=auto'
alias icat='kitty +kitten icat --align=left'

# Package Managment
alias upd='yay -Syu --noconfirm --quiet'
alias inst='yay -S --noconfirm'
alias uninst='yay -Rns --noconfirm'
alias rem='sudo pacman -Rns $(pacman -Qq | fzf)'
alias cleanup='sudo pacman -Rns $(pacman -Qtdq)'

# Change Shells
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
alias shork="~/blahaj/display3d ~/blahaj/blahaj.obj -t 0,0,6"

# Export fzf settings (mainly for fzf-tab)
export FZF_DEFAULT_OPTS=" \
--color=bg+:#1e1e2e,bg:#1e1e2e,spinner:#74c7ec,hl:#f5c2e7  \
--color=fg:#cdd6f4,header:#f5c2e7,info:#74c7ec,pointer:#f5c2e7  \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#74c7ec,hl+:#f5c2e7
--ansi  --no-scrollbar"

# Add autocorrection
setopt CORRECT

# Import Plugins 
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
source ~/.config/zsh/fzf-tab/fzf-tab.zsh

# Icons for lf 
export LF_ICONS="\
di=:\
fi=:\
ln=:\
or=:\
ex=:\
*.vimrc=:\
*.viminfo=:\
*.gitignore=:\
*.c=:\
*.cc=:\
*.clj=:\
*.coffee=:\
*.cpp=:\
*.css=:\
*.d=:\
*.dart=:\
*.erl=:\
*.exs=:\
*.fs=:\
*.go=:\
*.h=:\
*.hh=:\
*.hpp=:\
*.hs=:\
*.html=:\
*.java=:\
*.jl=:\
*.js=:\
*.json=:\
*.lua=:\
*.md=:\
*.php=:\
*.pl=:\
*.pro=:\
*.py=:\
*.rb=:\
*.rs=:\
*.scala=:\
*.ts=:\
*.vim=:\
*.cmd=:\
*.ps1=:\
*.sh=:\
*.bash=:\
*.zsh=:\
*.fish=:\
*.tar=:\
*.tgz=:\
*.arc=:\
*.arj=:\
*.taz=:\
*.lha=:\
*.lz4=:\
*.lzh=:\
*.lzma=:\
*.tlz=:\
*.txz=:\
*.tzo=:\
*.t7z=:\
*.zip=:\
*.z=:\
*.dz=:\
*.gz=:\
*.lrz=:\
*.lz=:\
*.lzo=:\
*.xz=:\
*.zst=:\
*.tzst=:\
*.bz2=:\
*.bz=:\
*.tbz=:\
*.tbz2=:\
*.tz=:\
*.deb=:\
*.rpm=:\
*.jar=:\
*.war=:\
*.ear=:\
*.sar=:\
*.rar=:\
*.alz=:\
*.ace=:\
*.zoo=:\
*.cpio=:\
*.7z=:\
*.rz=:\
*.cab=:\
*.wim=:\
*.swm=:\
*.dwm=:\
*.esd=:\
*.jpg=:\
*.jpeg=:\
*.mjpg=:\
*.mjpeg=:\
*.gif=:\
*.bmp=:\
*.pbm=:\
*.pgm=:\
*.ppm=:\
*.tga=:\
*.xbm=:\
*.xpm=:\
*.tif=:\
*.tiff=:\
*.png=:\
*.svg=:\
*.svgz=:\
*.mng=:\
*.pcx=:\
*.mov=:\
*.mpg=:\
*.mpeg=:\
*.m2v=:\
*.mkv=:\
*.webm=:\
*.ogm=:\
*.mp4=:\
*.m4v=:\
*.mp4v=:\
*.vob=:\
*.qt=:\
*.nuv=:\
*.wmv=:\
*.asf=:\
*.rm=:\
*.rmvb=:\
*.flc=:\
*.avi=:\
*.fli=:\
*.flv=:\
*.gl=:\
*.dl=:\
*.xcf=:\
*.xwd=:\
*.yuv=:\
*.cgm=:\
*.emf=:\
*.ogv=:\
*.ogx=:\
*.aac=:\
*.au=:\
*.flac=:\
*.m4a=:\
*.mid=:\
*.midi=:\
*.mka=:\
*.mp3=:\
*.mpc=:\
*.ogg=:\
*.ra=:\
*.wav=:\
*.oga=:\
*.opus=:\
*.spx=:\
*.xspf=:\
*.pdf=:\
*.nix=:\
"
