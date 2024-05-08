#!/bin/sh
fzf_style="--color=bg+:#1e1e2e,bg:#1e1e2e,spinner:#74c7ec,hl:#f5c2e7 --color=fg:#cdd6f4,header:#f5c2e7,info:#74c7ec,pointer:#f5c2e7 --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#74c7ec,hl+:#f5c2e7 --ansi  --no-scrollbar"



print_message() {
    echo -e "\e[1;36m \e[0m$1\e[0m"
}
if [[ $1 == "" ]]; then
    wallpaper="$(find ~/Pictures -type f | fzf $fzf_style)"
else
    wallpaper=$1
fi

nohup swww img $wallpaper -t wave > /dev/null 2>&1 &

# Set Wallpaper
print_message "Setting Wallpaper to $wallpaper"

# Get wallpaper colors 
print_message "Extracting colors from $wallpaper"
ffmpeg -y -i $wallpaper -vf "scale=320:-1" ~/Pictures/tmp_dont_look_at_it.jpg > /dev/null 2>&1 
wallpaper_colors=$(convert ~/Pictures/tmp_dont_look_at_it.jpg +dither -colors 6 -unique-colors txt: | tail -n 6 | awk -F " " '{print $3}' | tr -d "#")
rm ~/Pictures/tmp_dont_look_at_it.jpg &


max_delta=0
min_difference=1000000

# Better colors for calculations
colors=(
    FF6666 # Red
    9966FF # Purple
    FFA833 # Orange
    FFFF66 # Yellow
    FF99AA # Pink
    66FF66 # Green
    6699FF # Blue
)

# Pick most saturated color 
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
print_message "Picked most saturated color (#$wallpaper_color)"

# Pick color
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

# Translate to catppuccin pallette
case "$accent_color" in
    "FF6666") accent_name="red" accent_hex="F38BA8" accent_ansi="31";;
    "9966FF") accent_name="mauve" accent_hex="CBA6F7" accent_ansi="35";;
    "FFA833") accent_name="peach" accent_hex="FAB387" accent_ansi="33";;
    "FFFF66") accent_name="yellow" accent_hex="F9E2AF" accent_ansi="33";;
    "FF99AA") accent_name="pink" accent_hex="F5C2E7" accent_ansi="35";;
    "66FF66") accent_name="green" accent_hex="A6E3A1" accent_ansi="32";;
    "6699FF") accent_name="sapphire" accent_hex="74C7EC" accent_ansi="34";;
esac
print_message "Picked matching catppuccin color ($accent_name)"

# hypr stuff
echo "
general{
    col.active_border=rgb($accent_hex)
}
plugin {
    hyprtrails {
        color = rgba(${accent_hex}C0)
    }
}" > ~/.config/hypr/border.conf &
print_message "Changed border and trail colors"

# Change icons
papirus-folders -C cat-mocha-$accent_name -t Papirus-Dark > /dev/null 2>&1 # TODO make it faster
print_message "Changed icon colors"

# gtk 4 stuff
rm ~/.config/gtk-4.0
ln -sf /usr/share/themes/Catppuccin-Mocha-Standard-${accent_name^}-Dark/gtk-4.0 ~/.config/gtk-4.0 
print_message "Changed gtk 4 theme"

# gtk 3 stuff
sed -i "s/gtk-theme-name=$(awk -F'=' '/^gtk-theme-name/{print $2}' ~/.config/gtk-3.0/settings.ini)/gtk-theme-name=Catppuccin-Mocha-Standard-${accent_name^}-Dark/" ~/.config/gtk-3.0/settings.ini &
gsettings set org.gnome.desktop.interface gtk-theme "Catppuccin-Mocha-Standard-${accent_name^}-Dark" &
print_message "Changed gtk 3 theme"

# ags!!! 
echo "\$accent: #$accent_hex;" > ~/.config/ags/scss/_colors.scss
killall ags  
hyprctl dispatch exec ags
print_message "Changed ags theme"

# Terminal

## Starship 
if [[ $(head -n 1 ~/.config/starship.toml | tr -d "# ") == "acc" ]]; then
    cp ~/.config/starship/dynamic.toml ~/.config/starship.toml # copy template
    sed -i "s/col1/#$accent_hex/g" ~/.config/starship.toml
    sed -i "s/col2/#cdd6f4/g" ~/.config/starship.toml
    sed -i "s/col3/#$accent_hex/g" ~/.config/starship.toml
    print_message "Changed starship theme"
fi
## fastfetch
if [[ $(head -n 1 ~/.config/fastfetch/config.jsonc | tr -d "/ ") == "acc" ]]; then
    cp ~/.config/fastfetch/configs/dynamic.jsonc ~/.config/fastfetch/config.jsonc
    sed -i "s/col1/$accent_ansi/g" ~/.config/fastfetch/config.jsonc 
    print_message "Changed fastfetch theme"
fi

