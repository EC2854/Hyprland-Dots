#!/bin/bash

hyprctl monitors | grep eDP-1 && {
    hyprctl keyword monitor HDMI-A-2,2560x1080@100,0x0,1
    hyprctl keyword monitor eDP-1,disabled
} || {
    hyprctl keyword monitor eDP-1,1920x1080@60,0x0,1
    hyprctl keyword monitor HDMI-A-2,disabled
}

