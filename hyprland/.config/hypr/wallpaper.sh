#!/bin/bash

killall -q awww-daemon

awww-daemon &

awww img $HOME/Pictures/Wallpapers/arch.jpg --transition-type wipe --transition-angle 30 
