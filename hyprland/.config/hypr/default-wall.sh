#!/usr/bin/env bash

wallpaperdir="$HOME/Pictures/Wallpapers"  
wallpaper="$wallpaperdir/gojo.jpg"

check=$(pgrep awww-daemon)
if [[ $? -eq 0 ]]; then
    :
else
    awww-daemon &
fi

awww img $wallpaper --transition-type wipe --transition-angle 30
matugen image $wallpaper --prefer lightness #saturation 
