#!/bin/bash
source ~/.config/zsh/fzf-style.zsh # import fzf settings 
dir=~/Pictures/Wallpapers
tmp_image=$(mktemp /tmp/wall-low.XXXXXX.jpg)

# select="yad --file --add-preview --large-preview --image-filter --title 'Choose Wallpaper' --filename '~/Pictures/Wallpapers'"


print_message() {
    echo -e "\e[1;36m \e[0m$1\e[0m"
}
[ -z $1  ] && wallpaper="$( find $dir -type f |  fzf --preview 'chafa -f sixel --size 60 --animate no {}')" || wallpaper=$1

# ctrl c exit
[ -z $wallpaper ] && exit 0
print_message "Setting Wallpaper to $wallpaper"

# Set Wallpaper 
[[ "$wallpaper" = *".gif" ]] && {
    tmp_wallpaper=$(mktemp /tmp/wall.XXXXXX.jpg)

    ffmpeg -y -i "$wallpaper" -vf "scale=-1:1080" "$tmp_wallpaper" > /dev/null 2>&1
    swww img $tmp_wallpaper -t wave > /dev/null 2>&1 &

    nohup swww img $wallpaper -t none > /dev/null 2>&1 &
} || {
    nohup swww img $wallpaper -t wave > /dev/null 2>&1 &
}

# Get wallpaper colors 
ffmpeg -y -i "$wallpaper" -vf "scale=320:-1" "$tmp_image" > /dev/null 2>&1
wallpaper_colors=$(magick "$tmp_image" +dither -colors 6 -unique-colors txt: | tail -n 6 | awk -F " " '{print $3}' | tr -d "#")

rm "$tmp_image"
[ -z $tmp_wallpaper ] || rm "$tmp_wallpaper"

max_delta=0
min_distance=1000000

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

# Convert a hex color to its RGB components
hex_to_rgb() {
    echo "$((16#${1:0:2})) $((16#${1:2:2})) $((16#${1:4:2}))"
}

color_distance() {
    local r1=$1 g1=$2 b1=$3
    local r2=$4 g2=$5 b2=$6
    bc <<< "($r1 - $r2)^2 + ($g1 - $g2)^2 + ($b1 - $b2)^2"
}

# Pick most saturated color 
for color in $wallpaper_colors; do
    # Convert hex color to RGB components
    read r g b <<< $(hex_to_rgb $color)

    # Find the max and min RGB components
    max_color=$r
    min_color=$r
    [ $g -gt $max_color ] && max_color=$g
    [ $b -gt $max_color ] && max_color=$b
    [ $g -lt $min_color ] && min_color=$g
    [ $b -lt $min_color ] && min_color=$b

    # Calculate delta
    delta=$( bc <<< "$max_color - $min_color")

    # Compare to previous delta
    [ $delta -gt $max_delta ] && {
        max_delta=$delta
        wallpaper_color=$color
    } 
done
print_message "Picked most saturated color (#$wallpaper_color)"

# Pick the closest color
for color in "${colors[@]}"; do
    distance=$(color_distance $(hex_to_rgb $wallpaper_color) $(hex_to_rgb $color))
    [ "$distance" -lt "$min_distance" ] && {
        min_distance=$distance
        accent_color=$color
    } 
done

# Translate to catppuccin pallette
case "$accent_color" in
   "FF6666") accent_name="red"      accent_color="F38BA8" accent_ansi="31";;
   "9966FF") accent_name="mauve"    accent_color="CBA6F7" accent_ansi="35";;
   "FFA833") accent_name="peach"    accent_color="FAB387" accent_ansi="33";;
   "FFFF66") accent_name="yellow"   accent_color="F9E2AF" accent_ansi="33";;
   "FF99AA") accent_name="pink"     accent_color="F5C2E7" accent_ansi="35";;
   "66FF66") accent_name="green"    accent_color="A6E3A1" accent_ansi="32";;
   "6699FF") accent_name="sapphire" accent_color="74C7EC" accent_ansi="34";;
esac


gtk_theme="catppuccin-mocha-${accent_name}-Dark"

print_message "Picked matching catppuccin color ($accent_name)"

# hypr stuff
cat << EOF > ~/.config/hypr/border.conf
general {
    col.active_border=rgb($accent_color)
}
plugin {
    hyprtrails {
        color = rgba(${accent_color}C0)
    }
}
EOF
print_message "Changed border and trail colors"

# Change icons
{
    sed -i "s/^gtk-theme-name=.*/gtk-theme-name=$gtk_theme/" ~/.config/gtk-3.0/settings.ini &&
    gsettings set org.gnome.desktop.interface gtk-theme "$gtk_theme" &&
    print_message "Changed gtk 3 theme" 
} &
{
    rm -rf ~/.config/gtk-4.0
    ln -sf ~/.local/share/themes/$gtk_theme/gtk-4.0 ~/.config/gtk-4.0 && 
    print_message "Changed gtk 4 theme"
} &
# vesktop
{
    echo "@import 'https://catppuccin.github.io/discord/dist/catppuccin-mocha-$accent_name.theme.css'" > ~/.config/vesktop/settings/quickCss.css &&
    print_message "Changed vesktop theme"
} &
# ags!!! 
{
    echo "\$accent: #$accent_color;" > ~/.config/ags/scss/_colors.scss &&
    killall ags &&
    hyprctl dispatch exec ags > /dev/null &&
    print_message "Changed ags theme"
} &

# function for template based changes
template_change() {
    local directory=$1
    local template_directory=$(head -n 2 $directory | tail -n 1 | awk -F ' ' '{print $2}')
    local color=$2

    head -n 1 $directory | grep -q acc && {
        cp ~/$template_directory $directory # Copy template 
        sed -i "s/col1/$color/g" $directory
        [ -z $3 ] || sed -i "s/col2/$3/g" $directory &&
        [ -z $4 ] || sed -i "s/col3/$4/g" $directory 
    }
}

template_change ~/.config/starship.toml "#$accent_color" "#cdd6f4" "#$accent_color" && print_message "Changed Starship theme" &
template_change ~/.config/fastfetch/config.jsonc "$accent_ansi" && print_message "Changed fastfetch theme" &
template_change ~/.config/zsh/fzf-style.zsh  "#$accent_color" && print_message "Changed fzf theme" &
template_change ~/.config/yazi/theme.toml "#$accent_color"&& print_message "Changed Yazi theme"&
template_change ~/.config/nvim/lua/EC2854/plugins/intro.lua "$accent_name" && print_message "Changed Neovim theme" &

papirus-folders -C cat-mocha-$accent_name -t Papirus-Dark > /dev/null 2>&1 &&
print_message "Changed icon colors"
