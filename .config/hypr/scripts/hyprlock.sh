wallpaper=$(swww query | awk -F "image: " '{print $2}')
destination=~/Pictures/Wallpapers/hyprlock.png

ffmpeg -y -v 0 -i $wallpaper $destination
hyprlock
