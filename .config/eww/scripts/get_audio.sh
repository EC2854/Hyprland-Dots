#!/usr/bin/env bash


get_volume() {
    awk '{print int($2*100)}' <<< "$volume"
}

is_volume_muted() {
    grep MUTED <<< "$volume" > /dev/null 
}

get_mic() {
    awk '{print int($2*100)}' <<< "$mic"
}

is_mic_muted() {
    grep MUTED <<< "$mic" > /dev/null 
}


get_volume_icon() {
    local volume_power=$1
    if [ "$volume_power" -le 0 ] || eval is_volume_muted; then
        eww update volume_muted=true
        echo "󰝟"
    elif [ "$volume_power" -le 30 ]; then
        eww update volume_muted=false
        echo "󰕿"
    elif [ "$volume_power" -le 60 ]; then
        eww update volume_muted=false
        echo "󰖀"
    else
        eww update volume_muted=false
        echo "󰕾"
    fi
}

function get_mic_icon() {
    if eval is_mic_muted; then
        eww update mic_muted=true
        echo "󰍭"
    else
        eww update mic_muted=false
        echo "󰍬"
    fi
}



function audio_state() {
    echo "{ \"volume_icon\": \"$1\", \"volume_value\": \"$2\", \"mic_icon\" : \"$3\", \"mic_value\" : \"$4\" }"
}



notify_ui() {
    volume=$(wpctl get-volume @DEFAULT_SINK@)
    mic=$(wpctl get-volume @DEFAULT_SOURCE@)
    volume_power=$(get_volume)
    volume_icon=$(get_volume_icon "$volume_power")
    mic_icon=$(get_mic_icon)
    mic_power=$(get_mic)
    audio_state "$volume_icon" "$volume_power" "$mic_icon" "$mic_power"
}

notify_ui

pactl subscribe | grep --line-buffered "sink\|source" | while read -r _; do
    notify_ui
done


