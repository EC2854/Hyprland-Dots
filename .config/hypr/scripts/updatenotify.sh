#!/bin/bash

update_number=$(checkupdates | wc -l)
[ $update_number -gt 30 ] && notify-send "Update ur system" "$update_number updates available"
