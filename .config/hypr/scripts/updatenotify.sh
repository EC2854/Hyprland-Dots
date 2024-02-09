#!/bin/bash
update_number=$(checkupdates | wc -l)
if [[ $update_number > 0 ]]; then
    notify-send "$update_number updates available"
fi
