wallpaper=$(cat ~/.cache/swww/$(ls ~/.cache/swww | tail -n 1) | awk -F '%' '{print $1}')
destination=~/Pictures/Wallpapers/hyprlock.png

cp $wallpaper $destination
hyprlock
