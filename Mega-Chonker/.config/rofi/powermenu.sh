#! /bin/sh

chosen=$(printf "  Power Off\n  Restart\n  Suspend\n  Lock\n󰍃  Log Out" | rofi -dmenu -i -theme-str '@import "config.rasi"')

case "$chosen" in
    "  Power Off") systemctl poweroff;;
    "  Restart") systemctl reboot;;
    "  Suspend") systemctl suspend;;
    "  Lock") swaylock;;
    "󰍃 Log Out") hyprctl dispatch exit 0;;
    *) exit 1 ;;
esac
