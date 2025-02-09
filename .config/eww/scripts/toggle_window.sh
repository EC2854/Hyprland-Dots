#!/usr/bin/env bash

if eww active-windows | grep -q "$1"; then
    eww close "$1"
else
    eww open "$1"
fi

