#!/usr/bin/env bash

get_battery_level() {
    acpi -b | sed -e "s/[A-Za-z:,-.%]\+//g" | awk 'NR == 1 {print $2}'
}

get_adapter_status() {
    acpi -b | awk 'NR == 1 {print $3}' | sed -e 's/,//g'
}

charged_icon=("󰢟" "󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰂊" "󰂋" "󰂅")
discharged_icon=("󱃍" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰂀" "󰂁" "󰂂" "󰁹")

battery_level="$(get_battery_level)"
adapter_status="$(get_adapter_status)"

size=${#charged_icon[@]}
index=$(( (battery_level - 1) / size ))

if [ "$battery_level" -lt 20 ]; then
    eww update battery_low=true
else
    eww update battery_low=false
fi

if [[ $adapter_status = "Charging" ]]; then
    icon="${charged_icon[$index]}"
elif [[ $adapter_status = "Discharging" ]]; then
    icon="${discharged_icon[$index]}"
elif [[ $adapter_status = "Full" ]]; then 
    icon="󰁹"
else
    icon="󰂄"
fi

echo "{ \"icon\":\"$icon\", \"value\": \"$battery_level\" }"
