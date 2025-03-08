#!/usr/bin/env bash
theme_color=$1
[ -z "$theme_color" ] && exit 1

max_delta=0
min_distance=1000000

colors=(
    A1A1FF
    7A6B6B
    A2F2A2
    F0B674
    D787D7
    9F1F9F
    D06A6A
    888888
    7FDFDF
    E2E168
)
hex_to_rgb() {
    echo "$((16#${1:0:2})) $((16#${1:2:2})) $((16#${1:4:2}))"
}

color_distance() {
    local r1=$1 g1=$2 b1=$3
    local r2=$4 g2=$5 b2=$6
    bc <<< "($r1 - $r2)^2 + ($g1 - $g2)^2 + ($b1 - $b2)^2"
}

# Pick the closest color
for color in "${colors[@]}"; do
    distance=$(color_distance $(hex_to_rgb $theme_color) $(hex_to_rgb $color))
    [ "$distance" -lt "$min_distance" ] && {
        min_distance=$distance
        accent_color=$color
    } 
done

case "$accent_color" in
    "A1A1FF") name="blue";;
    "7A6B6B") name="brown";;
    "A2F2A2") name="green";;
    "F0B674") name="orange";;
    "D787D7") name="pink";;
    "9F1F9F") name="purple";;
    "D06A6A") name="red";;
    "888888") name="slate";;
    "7FDFDF") name="teal";;
    "E2E168") name="yellow";;
esac

icon_theme="Adwaita-${name}"
sed -i "s/^gtk-icon-theme-name=.*/gtk-icon-theme-name=$icon_theme/" ~/.config/gtk-3.0/settings.ini
gsettings set org.gnome.desktop.interface icon-theme "$icon_theme"
