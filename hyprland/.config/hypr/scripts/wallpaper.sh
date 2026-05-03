#!/usr/bin/env bash

wallpaperdir="$HOME/Pictures/Wallpapers"

check=$(pgrep awww-daemon)
if [[ $? -eq 0 ]]; then
    :
else
    awww-daemon &
fi

files=()                                                                    
                                                                              
while IFS= read -r -d $'\0' file; do                                        
    files+=("$file")                                                        
done < <(find "$wallpaperdir" -type f -print0)                  
                                                                              
if [ ${#files[@]} -eq 0 ]; then                                             
    exit 1                                                                  
fi                                                                          
                                                                              
rand=$(( RANDOM % ${#files[@]} ))                                           
output="${files[$rand]}" 

awww img $output --transition-type grow --transition-pos center --transition-fps 60 --transition-duration 1.1 
matugen image $output --prefer saturation #lightness #saturation
