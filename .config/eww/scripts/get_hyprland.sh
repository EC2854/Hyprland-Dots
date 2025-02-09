#!/usr/bin/env bash
handle() {
    case $1 in
        workspace*) workspace=$(hyprctl monitors -j | jq '.[] | select(.focused) | .activeWorkspace.id');;
        activewindow*) title=$(hyprctl activewindow -j | jq -r '.title | if length > 45 then .[:45] + "…" else . end') ;;
    esac

    echo "{ \"workspace\": \"$workspace\", \"title\": \"$title\" }"
}

socat -U - UNIX-CONNECT:"$XDG_RUNTIME_DIR"/hypr/"$HYPRLAND_INSTANCE_SIGNATURE"/.socket2.sock | while read -r line; do handle "$line"; done
