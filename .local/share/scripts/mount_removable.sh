#!/usr/bin/env bash

selected_device=$(lsblk -Al -o NAME,SIZE,TYPE,LABEL,MOUNTPOINT,RM -J | jq -r '
    .blockdevices[] |
    select(.rm == true and .type == "part") | 
    "\(.label // .name)\t(\(.name))\t\(.size)\t\(.mountpoint // "Not mounted")"
    ' | fzf)

if [ -n "$selected_device" ]; then
    device_name=$(echo "$selected_device" | awk -F'\t' '{print $2}' | tr -d "()")

    mount_point=$(lsblk -ro NAME,MOUNTPOINT | grep "$device_name" | awk '{print $2}')

    if [ -z "$mount_point"  ]; then
        udisksctl mount -b "/dev/$device_name"
        echo -e "Mounted: $device_name"
    else
        udisksctl unmount -b "/dev/$device_name"
        echo -e "Unmounted: $device_name"
    fi
else
    echo "No partition selected"
fi

