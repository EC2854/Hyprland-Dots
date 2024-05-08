#!/bin/bash
if [[ $1 == "" ]]; then
    prompt=$(ls ~/.config/starship/*.toml | fzf)

else
    prompt=$1
fi
if [[ $2 == "" ]]; then
    fetch=$(ls ~/.config/fastfetch/configs/*.jsonc | fzf)

else
    fetch=$2
fi

cp $prompt ~/.config/starship.toml
cp $fetch ~/.config/fastfetch/config.jsonc
