#!/bin/bash

killall waybar
killall dunst

waybar -c ~/.config/waybar/config.jsonc & -s ~/.config/waybar/style.css
dunst &
