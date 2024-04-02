#!/bin/sh
wallpaper_colors=$(convert $1 +dither -colors 6 -unique-colors txt: | tail -n 6 | awk -F " " '{print $3}' | tr -d "#")
swww img $1 -t wave 


max_delta=0
min_difference=1000000

colors=(
    FF6666
    9966FF
    FFA833
    FFFF66
    FF99AA
    66FF66
    6699FF
)

for color in $wallpaper_colors; do
    r=$(echo "ibase=16;${color:0:2}" | bc)
    g=$(echo "ibase=16;${color:2:2}" | bc)
    b=$(echo "ibase=16;${color:4:2}" | bc)

    max_color=$(printf "%d\n" $r $g $b | sort -nr | head -n 1)
    min_color=$(printf "%d\n" $r $g $b | sort -n | head -n 1)
    delta=$((max_color - min_color))

    if [ $delta -gt $max_delta ]; then
        wallpaper_color=$color
        max_delta=$delta
    fi
done

for c in "${colors[@]}"; do
    r=$(echo "ibase=16;${c:0:2}" | bc)
    g=$(echo "ibase=16;${c:2:2}" | bc)
    b=$(echo "ibase=16;${c:4:2}" | bc)
    
    wr=$(echo "ibase=16;${wallpaper_color:0:2}" | bc)
    wg=$(echo "ibase=16;${wallpaper_color:2:2}" | bc)
    wb=$(echo "ibase=16;${wallpaper_color:4:2}" | bc)

    dr=$(echo "$wr - $r" | bc | tr -d '-')
    dg=$(echo "$wg - $g" | bc | tr -d '-')
    db=$(echo "$wb - $b" | bc | tr -d '-')
   
   difference=$(echo "$dr + $dg + $db" | bc )

    if [ $difference -lt $min_difference ]; then
        accent_color=$c
        min_difference=$difference
    fi
done
rm ~/.config/gtk-4.0

case "$accent_color" in
    "FF6666") accent_name="red" accent_hex="F38BA8";;
    "9966FF") accent_name="mauve" accent_hex="CBA6F7";;
    "FFA833") accent_name="peach" accent_hex="FAB387";;
    "FFFF66") accent_name="yellow" accent_hex="F9E2AF";;
    "FF99AA") accent_name="pink" accent_hex="F5C2E7";;
    "66FF66") accent_name="green" accent_hex="A6E3A1";;
    "6699FF") accent_name="sapphire" accent_hex="74C7EC";;
esac

echo "general{
    col.active_border=rgb($accent_hex)
}" > ~/.config/hypr/border.conf

papirus-folders -C cat-mocha-$accent_name -t Papirus-Dark

# gtk 4 stuff
sudo ln -sf /usr/share/themes/Catppuccin-Mocha-Standard-${accent_name^}-Dark/gtk-4.0 ~/.config/gtk-4.0

# gtk 3 stuff
sed -i "s/gtk-theme-name=$(awk -F'=' '/^gtk-theme-name/{print $2}' ~/.config/gtk-3.0/settings.ini)/gtk-theme-name=Catppuccin-Mocha-Standard-${accent_name^}-Dark/" ~/.config/gtk-3.0/settings.ini
gsettings set org.gnome.desktop.interface gtk-theme "Catppuccin-Mocha-Standard-${accent_name^}-Dark"

# ags!!! 
echo "\$accent: #$accent_hex;" > ~/.config/ags/scss/_colors.scss
sassc ~/.config/ags/scss/main.scss ~/.config/ags/style.css
killall ags 
ags &
