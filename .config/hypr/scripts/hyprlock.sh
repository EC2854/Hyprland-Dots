#!/bin/bash

wallpaper=$(cat ~/.cache/wall/current_wall)
destination=~/.cache/hyprlock.png

ffmpeg -y -v 0 -i $wallpaper $destination
hyprlock
