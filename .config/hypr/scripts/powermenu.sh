#! /bin/sh

chosen=$(printf "  Power Off\n  Restart\n  Suspend\n  Lock\n󰍃  Log Out" | anyrun --plugins libstdin.so --show-results-immediately true)

case "$chosen" in
    "  Power Off") systemctl poweroff;;
    "  Restart") systemctl reboot;;
    "  Lock") hyprlock;;
    "󰍃 Log Out") hyprctl dispatch exit;;
    *) exit 1 ;;
esac
