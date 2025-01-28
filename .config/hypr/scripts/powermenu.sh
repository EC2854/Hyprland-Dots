#!/bin/bash

chosen=$(printf "  Power Off\n  Restart\n  Suspend\n  Lock\n󰍃  Log Out" | tofi)

case "$chosen" in
    "  Power Off") systemctl poweroff;;
    "  Restart") systemctl reboot;;
    "  Suspend") systemctl suspend;;
    "  Lock") ~/.config/hypr/scripts/hyprlock.sh;;
    "󰍃 Log Out") hyprctl dispatch exit;;
    *) exit 1 ;;
esac
