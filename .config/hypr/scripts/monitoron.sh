#!/bin/sh
hyprctl keyword monitor HDMI-A-1,1920x1080@75,2560x0,1
hyprctl keyword monitor HDMI-A-2,2560x1080@100,0x0,1
sleep 4
swww init
