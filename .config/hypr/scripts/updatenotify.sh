#!/bin/bash
update_number=$(checkupdates | wc -l)
if [[ $update_number > 50 ]]; then
    notify-send "Update ur system" "$update_number updates available"
fi
