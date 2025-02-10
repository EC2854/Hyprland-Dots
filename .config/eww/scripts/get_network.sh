#!/usr/bin/env bash

WIRELESS_NAME="wlan"
WIRED_NAME="enp"

DOMAINS=("amazon.com" "github.com" "gnu.org" "archlinux.org" "duckduckgo.com" "youtube.com" "nhentai.net" "wikipedia.org" "google.com" "reddit.com" "cloudflare.com" "spotify.com" "mozilla.org")
DOMAIN=$(printf "%s\n" "${DOMAINS[@]}" | shuf -n 1)

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

if resolvectl query --cache no "$DOMAIN" &>/dev/null; then
    status=yes
else 
    status=no
fi
    
echo "{ \"icon\":\"$icon\", \"name\":\"$name\", \"status\":\"$status\"}"
