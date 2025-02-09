#!/bin/bash

BRIGHTNESS_FILE="/sys/class/backlight/intel_backlight/brightness"


get_brightness_level() {
    brightnessctl -m | awk -F, '{print $4}' | tr -d '%'
}


get_icons() {
    if [[ $1 -le 16 ]]; then
        echo ""
    elif [[ $1 -gt 16 && $1 -lt 51 ]]; then
        echo ""
    elif [[ $1 -gt 51 && $1 -lt 90 ]]; then
        echo ""
    else 
        echo ""
    fi
}
# "", "", "", "", "", "", "", "", ""

handle() {
    brightness_level="$(get_brightness_level)"
  
    icon=$(get_icons "$brightness_level")
    echo "{ \"icon\":\"$icon\", \"value\": \"$brightness_level\" }"
}



handle
inotifywait -m -e modify "$BRIGHTNESS_FILE" 2>/dev/null | while read -r _; do
    handle
done
