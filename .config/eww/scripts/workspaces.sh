#!/bin/bash

WORKSPACES_NUMBER=6

workspaces() {
  WORKSPACE_WINDOWS=$(hyprctl workspaces -j | jq 'map({key: .id | tostring, value: .windows}) | from_entries')
  CURRENT="$(hyprctl -j monitors | jq '.[0].activeWorkspace.name')"

  seq 1 $WORKSPACES_NUMBER | \
  jq --argjson windows "${WORKSPACE_WINDOWS}" \
  --argjson current "${CURRENT}" \
  --slurp -Mc 'map(tostring) | map({id: ., windows: ($windows[.]//0), current: ($current == .)})'
}

workspaces
socat -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | while read -r line; do
  workspaces
done
