#!/usr/bin/env bash
ICON_DIR="/home/Ewa/.config/mako/icons/"
generate_bar() {
    local filled=$(($1 / 5))

    local bar="["
    for i in {1..20}; do
        if [ "$i" -lt "$filled" ]; then
            bar+="-"
        elif [ "$i" -eq "$filled" ]; then
            [ "$filled" -eq 20 ] && {
                bar+="-"
            } || {
                [ $((i%2)) -eq 0 ] && {
                    bar+="<b>C</b>"
                } || {
                    bar+="<b>c</b>"
                }
            }
        else
            [ $((i%2)) -eq 0 ] && {
                bar+=" "
            } || {
                bar+="o"
            }
        fi
    done
    bar+="]"
    echo "$bar"
}
notify-vol() {
    local message="$1"
    local source="$2"
    local icon="$3"
    wpctl get-volume "$source" | grep "MUTED" && {
        grep "SINK" <<< "$source" && local icon="${ICON_DIR}vol-mute.png"  || local icon="${ICON_DIR}mic-mute.png"
    }
    local precent=$(wpctl get-volume "$source" | awk '{print int($2 * 100)}')
    notify-send "$message ${precent}%" "$(generate_bar $precent )" -c volume -u low -i "$icon"

}
notify-brt() {
    local message="Brightness:"
    local precent=$(brightnessctl i | grep "Current" | awk -F '(' '{print $2}' | awk -F '%' '{print $1}')
    local icon="$1"
    notify-send "$message ${precent}%" "$(generate_bar $precent )" -c volume -u low -i "$icon"
}
vol_down() {
    wpctl set-volume @DEFAULT_SINK@ 0.05-
    notify-vol "Volume:" "@DEFAULT_SINK@" "${ICON_DIR}vol-down.png"
}
vol_up() {
    wpctl set-volume @DEFAULT_SINK@ 0.05+
    notify-vol "Volume:" "@DEFAULT_SINK@" "${ICON_DIR}vol-up.png"
}
vol_mute(){
    wpctl set-mute @DEFAULT_SINK@ toggle
    notify-vol "Volume:" "@DEFAULT_SINK@" "${ICON_DIR}vol-up.png"
}
mic_down() {
    wpctl set-volume @DEFAULT_SOURCE@ 0.05-
    notify-vol "Microphone:" "@DEFAULT_SOURCE@" "${ICON_DIR}mic-down.png"
}
mic_up() {
    wpctl set-volume @DEFAULT_SOURCE@ 0.05+
    notify-vol "Microphone:" "@DEFAULT_SOURCE@" "${ICON_DIR}mic-up.png"
}
mic_mute(){
    wpctl set-mute @DEFAULT_SOURCE@ toggle
    notify-vol "Microphone:" "@DEFAULT_SOURCE@" "${ICON_DIR}mic-up.png"
    
} 
brt_down(){
    brightnessctl s 5%-
    notify-brt "${ICON_DIR}brt-down.png"
}

brt_up(){
    brightnessctl s 5%+
    notify-brt "${ICON_DIR}brt-up.png"
}
sel() {
    local source="$1"
    local action="$2"

    case "$action" in
        up)
            "${source}"_up
        ;;
        down)
            "${source}"_down
        ;;
        mute)
            "${source}"_mute
        ;;
    esac
}


sel "$1" "$2"
