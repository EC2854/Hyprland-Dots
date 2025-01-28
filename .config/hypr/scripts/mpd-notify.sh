#!/bin/bash

get_data() {
    local data="$1"
    playerctl metadata "$data"
}
notify() {
    local title="$(playerctl metadata title)"
    local author="$(playerctl metadata artist)"

    local state="$(playerctl status)"
    if [[ "$state" == "Playing" ]]; then
        local state="󰝚"
    else
        local state="󰝛"
    fi

    # still there is '///' but it doesnt do anything bad so im keeping it :3
    local artwork="$(playerctl metadata mpris:artUrl | awk -F ':' '{print $2}')"

    notify-send "$state $title" "by <b>$author</b>" -i "$artwork" -c mpd -u low
}

playerctl $1
notify
