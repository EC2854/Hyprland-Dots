#!/usr/bin/env bash

if bluetoothctl show | grep "Powered: yes"; then
    bluetoothctl power off
else
    bluetoothctl power on
fi

