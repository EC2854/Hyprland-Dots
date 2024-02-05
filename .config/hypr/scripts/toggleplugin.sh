#!/bin/bash

get_state() {
    local state=$(hyprpm list | grep -A 1 "$1" | tail -n 1 | awk -F ':' '{print $2}')
    echo "$state"
}

plugin_name="$1"
state=$(get_state "$plugin_name")

if [[ "$state" == *"false"* ]]; then
    hyprpm enable "$plugin_name" > /dev/null 2>&1
else 
    hyprpm disable "$plugin_name" > /dev/null 2>&1 
fi
