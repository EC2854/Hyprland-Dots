#!/bin/bash
area=$(XCURSOR_THEME="Capitaine Cursors (Gruvbox)" slurp -b 1b1b1bb0 -c d4be98)
grim -g "$area" - | wl-copy
