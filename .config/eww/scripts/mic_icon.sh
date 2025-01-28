#!/usr/bin/env bash
mic=$(wpctl get-volume @DEFAULT_SOURCE@)
if grep MUTED <<< "$mic" > /dev/null; then
    eww update mic_muted=true
    echo "󰍭"
else
    eww update mic_muted=false
    echo "󰍬"
fi
