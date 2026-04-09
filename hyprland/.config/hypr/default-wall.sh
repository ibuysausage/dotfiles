#!/usr/bin/env bash

wallpaperdir="$HOME/Pictures/Wallpapers"  
wallpaper="$wallpaperdir/tokyonight-wallpapers/dragon_upscayl_realesrgan-x4plus_x2.png"

check=$(pgrep awww-daemon)
if [[ $? -eq 0 ]]; then
    :
else
    awww-daemon &
fi

awww img $wallpaper --transition-type wipe --transition-angle 30
