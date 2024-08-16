#!/bin/bash
wall=$(cat ~/.cache/wall/current_wall)
type=$(file -Lb --mime-type $wall)

[[ "$type" = "video"* ]] && 
    mpvpaper -sf -o "no-audio loop panscan=1.0 " "*" "$wall" > /dev/null 2>&1 ||
    hyprctl dispatch exec swww-daemon
