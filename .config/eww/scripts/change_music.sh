#!/usr/bin/env bash

if [[ $1 == "up" ]]; then
    playerctl next
else
    playerctl previous
fi
