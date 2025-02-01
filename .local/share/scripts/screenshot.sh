#!/usr/bin/env bash
area=$(XCURSOR_THEME="Capitaine Cursors" slurp -b 131318c0 -c c4c0ff)
grim -g "$area" - | wl-copy
