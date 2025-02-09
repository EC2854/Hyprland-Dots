#!/usr/bin/env bash

get_state() {
    bluetoothctl show | grep "Powered: " | awk '{print $2}'
}
get_name() {
    name=$(bluetoothctl devices Connected | head -n 1 | cut -d ' ' -f3-)
    [ -z "$name" ] && name="Bluetooth"
    echo "$name"
}

echo "{ \"powered\": \"$(get_state)\", \"name\": \"$(get_name)\" }"
