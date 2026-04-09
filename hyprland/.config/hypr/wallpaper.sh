#!/usr/bin/env bash

wallpaperdir="$HOME/Pictures/Wallpapers"
num=$(awk -v min=1 -v max=2 'BEGIN{srand(); print int(min+rand()*(max-min+1))}')

if [[ $num == 1 ]]; then
    output="$wallpaperdir/tokyonight-wallpapers/dragon_upscayl_realesrgan-x4plus_x2.png"
elif [[ $num == 2 ]]; then
    output="$wallpaperdir/arch.png"
fi

check=$(pgrep awww-daemon)
if [[ $? -eq 0 ]]; then
    :
else
    awww-daemon &
fi

awww img $output --transition-type wipe --transition-angle 30 
