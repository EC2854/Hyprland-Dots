#!/usr/bin/env bash
volume=$(wpctl get-volume @DEFAULT_SINK@)
if grep MUTED <<< "$volume" > /dev/null; then
    eww update volume_muted=true
    echo "󰝟"
else
    volume=$(awk '{print int($2*100)}' <<< "$volume")
    eww update volume_muted=false

    if [ "$volume" -gt 60 ]; then
        echo "󰕾"
    elif [ "$volume" -gt 30 ]; then
        echo "󰖀"
    elif [ "$volume" -gt 0 ]; then
        echo "󰕿"
    else
        eww update volume_muted=true
        echo ""
    fi
fi
