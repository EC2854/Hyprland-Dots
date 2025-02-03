#!/usr/bin/env bash

if [[ $1 == "up" ]]; then
    brightnessctl s 5%+
else
    brightnessctl s 5%-
fi
