#!/usr/bin/env bash

WIRELESS_NAME="wlan"
WIRED_NAME="enp"

interfaces=$(ip -j link | jq -r '.[] | select((.flags | index("UP")) and (.flags | index("LOWER_UP")) and (.link_type != "loopback")) | .ifname')


if grep -q "$WIRELESS_NAME" <<< "$interfaces"; then
    icon="󰖩"
    name=$(iwctl station "${WIRELESS_NAME}0" show | { grep "Connected network" || echo "Wifi"; } | cut -d ' ' -f19- )
elif grep -q "$WIRED_NAME" <<< "$interfaces"; then
    icon="󰈀"
    name=$(grep "$WIRED_NAME" <<< "$interfaces" | head -n 1)
else
    icon="󰤮"
    name="Network"
fi

if ping -c 1 1.1.1.1 > /dev/null ; then
    status=yes
else 
    status=no
fi
    
echo "{ \"icon\":\"$icon\", \"name\":\"$name\", \"status\":\"$status\"}"
