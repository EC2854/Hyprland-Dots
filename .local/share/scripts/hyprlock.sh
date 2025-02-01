#!/usr/bin/env bash

wallpaper=$(cat ~/.cache/swww/"$(hyprctl -j monitors | jq -r '.[].name')")
destination=~/.cache/hyprlock.png

ffmpeg -y -v 0 -i "$wallpaper" "$destination"
hyprlock
