#!/bin/bash
[ -z $1 ] && prompt=$(ls ~/.config/starship/*.toml | fzf) || prompt=$1
[ -z $2 ] && fetch=$(ls ~/.config/starship/*.toml | fzf) || fetch=$2
[ -z $3 ] && fzf=$(ls ~/.config/zsh/fzf-settings | fzf) || fzf=$3

cp $prompt ~/.config/starship.toml
cp $fetch ~/.config/fastfetch/config.jsonc
cp $fzf ~/.config/zsh/fzf-style.zsh
