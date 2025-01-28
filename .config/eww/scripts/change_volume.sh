#!/usr/bin/env bash

if [[ $1 == "up" ]]; then
    wpctl set-volume @DEFAULT_"$2"@ 0.05+
else
    wpctl set-volume @DEFAULT_"$2"@ 0.05-
fi
