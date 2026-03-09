#!/usr/bin/env bash

killall -q awww-daemon; rm -rf ~/.cache/awww/

awww-daemon &
awww img $HOME/Pictures/Wallpapers/arch.png --transition-type wipe --transition-angle 30 
