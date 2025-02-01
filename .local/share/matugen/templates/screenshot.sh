#!/usr/bin/env bash
area=$(XCURSOR_THEME="Capitaine Cursors" slurp -b {{colors.surface.default.hex_stripped}}c0 -c {{colors.primary.default.hex_stripped}})
grim -g "$area" - | wl-copy
