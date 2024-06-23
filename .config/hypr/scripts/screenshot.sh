#!/bin/bash
area=$(slurp -b 11111bdc)
grim -g "$area" - | wl-copy
