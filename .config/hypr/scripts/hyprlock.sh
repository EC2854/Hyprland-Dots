#!/bin/bash

wallpaper=$(swww query | awk -F "image: " '{print $2}')
destination=~/.cache/hyprlock.png

ffmpeg -y -v 0 -i $wallpaper $destination
hyprlock
