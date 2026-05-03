#!/usr/bin/env bash

wallpaperdir="$HOME/Pictures/Wallpapers"  
wallpaper="$wallpaperdir/dragon.png"

check=$(pgrep awww-daemon)
if [[ $? -eq 0 ]]; then
    :
else
    awww-daemon &
fi

awww img $wallpaper --transition-type grow --transition-pos center --transition-fps 60 --transition-duration 1.1 
#matugen image $wallpaper --prefer saturation #saturation 
matugen color hex 3B8A67
