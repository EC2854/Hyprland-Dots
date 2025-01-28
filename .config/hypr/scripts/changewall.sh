#!/bin/bash
source ~/.config/zsh/fzf-style.zsh # import fzf settings 
dir=~/Pictures/Wallpapers
# select="yad --file --add-preview --large-preview --image-filter --title 'Choose Wallpaper' --filename '~/Pictures/Wallpapers'"

print_message() {
    echo -e "\e[1;36m \e[0m$1\e[0m"
}
[ -z $1  ] && wallpaper="$( find $dir -type f |  fzf --preview 'chafa -f sixel --size 60 --animate no {}')" || wallpaper="$1"

# Convert a hex color to its RGB components
hex_to_rgb() {
    echo "$((16#${1:0:2})) $((16#${1:2:2})) $((16#${1:4:2}))"
}

color_distance() {
    local r1=$1 g1=$2 b1=$3
    local r2=$4 g2=$5 b2=$6
    bc <<< $(( (r1 - $r2)**2 + ($g1 - $g2)**2 + ($b1 - $b2)**2 ))
}

tmp_wallpaper=~/.cache/wall/wall.png
# ctrl c exit
[ -z "$wallpaper" ] && exit 0
print_message "Setting Wallpaper to $wallpaper"

# 
ps -ax | grep -v "grep" | grep "mpvpaper" > /dev/null 2>&1 && {
    hyprctl dispatch exec swww-daemon 
    killall -s KILL mpvpaper
    rm $tmp_wallpaper
}

# Set Wallpaper 
echo "$wallpaper" > ~/.cache/wall/current_wall

type=$(file -Lb --mime-type "$wallpaper")

case $type in
    "image/gif" | "video"* )
        ffmpeg -y -i "$wallpaper" -vf "scale=-1:1080" -vframes 1 $tmp_wallpaper > /dev/null 2>&1
        swww img $tmp_wallpaper -t wave --transition-duration=3 > /dev/null 2>&1 &

        sleep 3
        if [[ "$type" = "image/gif" ]]; then
            nohup swww img $wallpaper -t none > /dev/null 2>&1 &
            rm $tmp_wallpaper
        else
            killall swww-daemon
            nohup mpvpaper -sf -o "no-audio loop panscan=1.0 " "*" "$wallpaper" > /dev/null 2>&1 &
        fi
        ;;
    *)
        nohup swww img "$wallpaper" -t wave --transition-duration=3 > /dev/null 2>&1 &
        ;;
esac
