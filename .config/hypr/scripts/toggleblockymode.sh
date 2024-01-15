#!/bin/sh

if [[ $(hyprctl getoption decoration:rounding | grep -E 'int: 0') ]]
then
    killall waybar
    hyprctl keyword decoration:rounding 10
    hyprctl keyword general:gaps_in 8
    hyprctl keyword general:gaps_out 15
    hyprctl keyword general:col.active_border 0xfff38ba8 0xfffab387
    hyprctl keyword animations:enabled 1
    hyprctl keyword decoration:drop_shadow true
    waybar
else
    killall waybar
    hyprctl keyword decoration:rounding 0
    hyprctl keyword general:gaps_in 2
    hyprctl keyword general:gaps_out 3
    hyprctl keyword general:col.active_border 0xfffab387
    hyprctl keyword animations:enabled 0
    hyprctl keyword decoration:drop_shadow false
    waybar -c ~/.config/waybar/blocky/config -s ~/.config/waybar/blocky/style.css
fi
