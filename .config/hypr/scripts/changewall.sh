#!/bin/bash
fzf_style="--color=bg+:#1e1e2e,bg:#1e1e2e,spinner:#74c7ec,hl:#f5c2e7 --color=fg:#cdd6f4,header:#f5c2e7,info:#74c7ec,pointer:#f5c2e7 --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#74c7ec,hl+:#f5c2e7 --ansi --no-scrollbar"
dir=~/Pictures/Wallpapers
tmp_image=$(mktemp /tmp/wall-low.XXXXXX.jpg)

# select="yad --file --add-preview --large-preview --image-filter --title 'Choose Wallpaper' --filename '~/Pictures/Wallpapers'"


print_message() {
    echo -e "\e[1;36m \e[0m$1\e[0m"
}
[ -z $1  ] && wallpaper="$( find $dir -type f |  fzf $fzf_style --preview 'chafa -f sixel --size 60 --animate no {}')" || wallpaper=$1

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
    ln -sf ~/.themes/$gtk_theme/gtk-4.0 ~/.config/gtk-4.0 && 
    print_message "Changed gtk 4 theme"
} &
# vesktop
{
    echo "@import 'https://catppuccin.github.io/discord/dist/catppuccin-mocha-$accent_name.theme.css'" > ~/.config/vesktop/settings/quickCss.css &&
    print_message "Changed vesktop theme"
} &
# Spicetify
{
    cp ~/.config/spicetify/Themes/tui/dynamic.ini ~/.config/spicetify/Themes/tui/color.ini &&
    sed -i "s/col1/$accent_color/g" ~/.config/spicetify/Themes/tui/color.ini &&
    print_message "Changed spicetify theme" &&
    nohup spicetify apply > /dev/null 2>&1
} &

# ags!!! 
{
    echo "\$accent: #$accent_color;" > ~/.config/ags/scss/_colors.scss &&
    killall ags &&
    hyprctl dispatch exec ags > /dev/null &&
    print_message "Changed ags theme"
} &
# Terminal

## Starship 
head -n 1 ~/.config/starship.toml | grep -q acc && {
    cp ~/.config/starship/dynamic.toml ~/.config/starship.toml && # Copy template 
    sed -i "s/col1/#$accent_color/g" ~/.config/starship.toml &&
    sed -i "s/col2/#cdd6f4/g" ~/.config/starship.toml &&
    sed -i "s/col3/#$accent_color/g" ~/.config/starship.toml &&
    print_message "Changed starship theme"
} &
## fastfetch
head -n 1 ~/.config/fastfetch/config.jsonc | grep -q acc && {
    cp ~/.config/fastfetch/configs/dynamic.jsonc ~/.config/fastfetch/config.jsonc &&
    sed -i "s/col1/$accent_ansi/g" ~/.config/fastfetch/config.jsonc  &&
    print_message "Changed fastfetch theme"
} &

## Yazi

head -n 1 ~/.config/yazi/theme.toml | grep -q acc && {
    cp ~/.config/yazi/themes/dynamic.toml ~/.config/yazi/theme.toml &&
    sed -i "s/col1/#$accent_color/g" ~/.config/yazi/theme.toml  &&
    print_message "Changed yazi theme"
} &

# Neovim intro
{
    cp ~/.config/nvim/templates/intro.lua ~/.config/nvim/lua/EC2854/plugins/intro.lua &&
    sed -i "s/col1/$accent_name/g" ~/.config/nvim/lua/EC2854/plugins/intro.lua &&
    print_message "Changed Neovim theme"
} &

papirus-folders -C cat-mocha-$accent_name -t Papirus-Dark > /dev/null 2>&1 &&
print_message "Changed icon colors"
