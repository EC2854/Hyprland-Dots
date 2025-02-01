#!/usr/bin/env bash

# script to unmount all archivemounts on lf exit
command lf "$@"
# clean
awk '$1 == "archivemount" { print $2 }' /etc/mtab | while read -r mntdir; do
    sanitized_input="$(printf "$mntdir")"
    umount "$sanitized_input"
    rmdir "$sanitized_input"
done


