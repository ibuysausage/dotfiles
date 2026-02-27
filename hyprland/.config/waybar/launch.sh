#!/bin/bash

killall -q waybar
killall -q dunst

while pgrep -u $UID -x waybar >/dev/null; do sleep 1; done

export PATH=$PATH:$HOME/.local/bin:$HOME/.cargo/bin:/usr/local/bin

# 4. Launch waybar and log errors to a file so we can see what's happening
waybar -c ~/.config/waybar/config.jsonc & -s ~/.config/waybar/style.css
dunst &
