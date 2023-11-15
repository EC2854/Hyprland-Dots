#!/bin/sh
hyprctl keyword monitor HDMI-A-1,disable
hyprctl keyword monitor HDMI-A-2,2560x1080@100,0x0,1
sleep 2
swww init
