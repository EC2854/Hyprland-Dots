#!/bin/bash

plugin_name="$1"
get_state() {
    hyprpm list | grep -A 1 $plugin_name | grep false > /dev/null 2>&1
}
plugin() {
    hyprpm $1 $plugin_name > /dev/null 2>&1 && notify-send "$plugin_name ${1}d"
}

get_state $plugin_name && plugin enable || plugin disable

