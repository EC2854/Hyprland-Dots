wallpaper=$(cat ~/.cache/swww/$(ls ~/.cache/swww | tail -n 1) | awk -F '%' '{print $1}')
destination=~/Pictures/Wallpapers/hyprlock.png

ffmpeg -y -v 0 -i $wallpaper $destination
hyprlock
