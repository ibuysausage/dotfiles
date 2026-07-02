#!/bin/bash

pacman -Qe | awk '{print $1}' > package_list.txt
 for x in $(cat package_list.txt); do sudo pacman -S $x; done
