#!/usr/bin/env bash

if eww get "$1" | grep true; then
    eww update "$1"=false
else
    eww update "$1"=true
fi

