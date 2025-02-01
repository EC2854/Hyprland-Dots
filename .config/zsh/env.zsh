# variables for zsh and bash
# this file in sourced in .zshrc and .bashrc
export PATH="$PATH:/home/$USER/.local/share/scripts"

#fzf settings 
source ~/.config/zsh/fzf-style.zsh

# Colorize sudo prompt
export SUDO_PROMPT=$'\e[1;31m[sudo]\e[0m Enter a password for %u: '

# Default Apps
export EDITOR="nvim"
export VISUAL="nvim"
export BROWSER="librewolf"

# Manpager
export MANPAGER="less -R --use-color -Dd+b -Du+m"
export MANROFFOPT="-P -c"

export LESS='-R --use-color -Dd+b$Du+m$'

export GCM_CREDENTIAL_STORE="cache"

# XDG variables
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

# Cleaning ~
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java

export CARGO_HOME="$XDG_DATA_HOME"/cargo
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup

export GOPATH="$XDG_DATA_HOME"/go

export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc

