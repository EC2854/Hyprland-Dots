#!/usr/bin/env bash

COLOR_FILE="/tmp/term_colors.txt"

if [[ ! -f "$COLOR_FILE" ]]; then
    echo "$COLOR_FILE not found"
    exit 1
fi

mapfile -t colors < "$COLOR_FILE"

if [[ ${#colors[@]} -ne 18 ]]; then
    echo "expected 18 colors in $COLOR_FILE, found ${#colors[@]}"
    exit 1
fi
format_color() {
    local hex=$1
    echo "${hex:0:2}/${hex:2:2}/${hex:4:2}"
}

active_ttys=$(who | awk '{print $2}' | grep -v '^tty')

for i in {0..15}; do
    color=$(format_color "${colors[$i]}")
    for tty in $active_ttys; do
        echo -e "\e]4;$i;rgb:$color\a" > "/dev/$tty"
    done
done

bg=$(format_color "${colors[16]}")
fg=$(format_color "${colors[17]}")
for tty in $active_ttys; do
    echo -e "\e]11;rgb:$bg\a" > "/dev/$tty"
    echo -e "\e]10;rgb:$fg\a" > "/dev/$tty"
done
rm "$COLOR_FILE"
