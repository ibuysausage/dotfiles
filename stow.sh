#!/bin/bash
# Stows all files in the current dir

gum confirm "Do you wan't to stow all config dirs?"

if [[ $? == 0 ]]; then
    for dir in *; do
        if [[ -d $dir && ! $dir == "dependencies" && ! $dir == "hyprland" && ! $dir == "release" ]]; then
            echo "Applying config for $dir"
            stow $dir --adopt
        fi
    done
fi
