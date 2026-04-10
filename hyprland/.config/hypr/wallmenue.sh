#!/bin/bash
# https://www.reddit.com/r/hyprland/comments/1eb2bd0/wallpaper_selector_sxiv_swww_img/

effects=("grow" "wave" "any" "fade")
random_index=$(( RANDOM % ${#effects[@]} )) 
img=$(sxiv -to ~/Pictures/Wallpapers/ | awk -F'/' '{print $NF}')
echo "$img"
# awww img -t ${effects[random_index]} ~/Pictures/Wallpapers/$img
awww img -t --transition-type wipe --transition-angle 30 $HOME/Pictures/Wallpapers/$img
