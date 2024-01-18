#
# ~/.bashrc
#
eval "$(starship init bash)"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
PS1='[\u@\h \W]\$ '

source ~/.config/zsh/aliases.zsh
source ~/.config/zsh/env.zsh

