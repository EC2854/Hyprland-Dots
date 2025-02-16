# ⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⣿⡿⠻⣟⣻⣻⠿⣿⣿⣿⣿⣿⣿⣿⣿  _____ ____ ____  ___ ____  _  _   
# ⣿⣿⣿⣿⣿⣿⣿⢿⣿⣾⣿⣿⣿⣷⣜⢉⣟⣾⡷⣽⡻⣿⣿⣿⣿⣿ | ____/ ___|___ \( _ ) ___|| || |  
# ⣿⣿⣿⣿⣿⡿⣡⣾⣿⣿⣿⣿⡿⢿⣿⣷⡩⡽⣛⢷⣿⡪⡻⣿⣿⣿ |  _|| |     __) / _ \___ \| || |_ 
# ⣿⣿⣿⣿⡟⡾⡋⣼⣿⡿⠛⣩⣾⣿⡿⣫⣶⣿⡾⣿⣮⣿⡦⡙⣿⣿ | |__| |___ / __/ (_) |__) |__   _|
# ⣿⣿⣿⣿⢁⠞⣼⡏⡷⣡⡬⡿⣹⡿⣹⣿⢹⣧⢿⢨⡹⢨⡺⢷⡹⣿ |_____\____|_____\___/____/   |_|  
# ⣿⣿⣿⡟⢪⣸⣿⠸⣉⡟⠜⡵⡟⣼⣿⡇⣿⣿⣿⢸⡍⣔⢸⣸⢷⢹ -----------------------------------
# ⣿⣿⣿⣷⣎⠟⢸⣸⣭⠁⡞⣁⡇⣿⡿⣹⣿⣿⡻⠀⡇⣿⠎⢼⠺⢸ Ewa (EC2854)
# ⣿⣿⣿⣿⡛⠸⡇⢹⡏⠀⠈⠭⠘⡘⢣⠟⢡⠃⠑⠀⢸⠏⠚⠘⡆⣸ https://github.com/EC2854
# ⣿⣿⣿⣿⣷⡀⠩⡸⠁⢲⣤⣼⣷⠃⣀⡄⣠⣀⣸⠆⠀⠀⡄⣸⣷⣿ https://www.reddit.com/user/EC2854
# ⣿⣿⣿⣿⣿⣿⡦⠀⠨⡂⠨⣛⣧⣾⣯⢾⣿⣛⠁⠀⠀⠀⣿⣿⣿⣿ -----------------------------------
# ⣿⣿⣿⣿⣿⡿⣡⣶⣿⣷⣶⡌⣙⣛⣓⣾⡭⠁⠀⠀⢠⢰⣿⣿⣿⣿ Just a normal zshrc
# ⣿⣿⣿⡿⢏⣾⣿⣿⣿⣿⣿⣷⠘⠿⣻⣥⡀⣀⣴⣧⣿⣿⣿⣿⣿⣿ Part of https://github.com/EC2854/Hyprland-Dots
# ⣿⣟⣽⠊⣾⠟⠀⢀⢹⣿⣿⣿⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
# ⡿⠾⠇⠀⣿⡐⣨⣧⣾⣿⣿⡇⠈⢻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿

# Init
autoload -U compinit
zmodload zsh/complist
_comp_options+=(globdots) # Include hidden files.
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"

# Enable autocorrection
setopt CORRECT

# Source environment variables and aliases
source ~/.config/zsh/env.zsh
source ~/.config/zsh/aliases.zsh

# Zoxide init
eval "$(zoxide init --cmd cd zsh)"

# Fzf integration
FZF_ALT_C_COMMAND= 
FZF_CTRL_T_COMMAND= 
source <(fzf --zsh)

case ${TERM} in 
    linux*|tmux*)
        PROMPT="%B%F{magenta}[%f%b%B%F{blue}%n%f%b%B@%b%B%F{blue}%m%f%b%B%F{magenta}] [%f%b%B%F{blue}%~%f%b%B%F{magenta}]%f%b%B%F{magenta}
> %f%b"
    ;;
    *)
        eval "$(starship init zsh)"
    ;;

esac
# Starship prompt

# Fastfetch with random image
# fastfetch --logo-height 6 --sixel "$(find ~/Pictures/menhera-chan -type f | shuf -n 1)"
fastfetch

# History configuration
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$XDG_CACHE_HOME"/zsh/history

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

# Plugins :3 
zinit wait lucid light-mode for \
    Aloxaf/fzf-tab \
    zsh-users/zsh-history-substring-search \
    atinit"zicompinit; zicdreplay" \
        zsh-users/zsh-syntax-highlighting \
    atload"_zsh_autosuggest_start" \
        zsh-users/zsh-autosuggestions \

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Better history navigation
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Completion settings
zstyle ':completion:*' menu select
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:*' fzf-flags  $(awk -F ' ' '{print $1}' <<< ${FZF_DEFAULT_OPTS}) --no-scrollbar --no-hscroll --prompt ' ' --pointer '' --marker ''
zstyle ':fzf-tab:*' popup-min-size 80 12
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --icons=always --color=always --group-directories-first -a -1 $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza --icons=always --color=always --group-directories-first -a -1 $realpath'

bindkey -s '^o' 'lfcd\n'

# Edit line in Vim with ctrl-e
autoload edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line
