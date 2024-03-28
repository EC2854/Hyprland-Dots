#!/bin/bash
area=$(slurp -b 11111bdc)
grim -g "$area" - | wl-copy && notify-send "Screenshot taken" "screenshot saved to clipboard"
