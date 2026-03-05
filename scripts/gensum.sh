#!/bin/bash
gensumcache="$HOME/.cache/gensum.cache"
mkdir -p "$HOME/.cache/"

PACMAN_HASH=$(md5sum ../dependencies/pacman-arch.txt | cut -d ' ' -f1)
AUR_HASH=$(md5sum ../dependencies/aur-arch.txt | cut -d ' ' -f1)
echo "NEW PACMAN HASH IS $PACMAN_HASH"
echo "NEW AUR HASH IS $AUR_HASH"

if [ -f "$HOME/.cache/gensum.cache" ]; then
    PACMAN_LOADED_HASH=$(sed -n '1p' $HOME/.cache/gensum.cache)
    AUR_LOADED_HASH=$(sed -n '3p' $HOME/.cache/gensum.cache)
    echo "CURRENT PACMAN HASH IS $PACMAN_LOADED_HASH"
    echo "CURRENT AUR HASH IS $AUR_LOADED_HASH"
    sleep 1.5
else
    PACMAN_LOADED_HASH="NONE"
    AUR_LOADED_HASH="NONE"
    echo "CURRENT PACMAN HASH IS $PACMAN_LOADED_HASH"
    echo "CURRENT AUR HASH IS $AUR_LOADED_HASH"
    sleep 1.5
    echo "Creating hash file..."
    cp "../gensum.cache" "$HOME/.cache/gensum.cache"
    echo ""
fi


if [[ "$PACMAN_HASH" == "$PACMAN_LOADED_HASH" || "$AUR_HASH" == "$AUR_LOADED_HASH" ]]; then
    echo "Dependencies haven't changed. Keeping cache."
else
    echo "Dependencies changed or cache missing. Reseting cache..."
    curl -LO --output-dir ../ https://raw.githubusercontent.com/clippyricer/dotfiles/refs/heads/main/setup.cache --progress-bar
    cp ../setup.cache "$HOME/.cache/setup.cache"
    setupcache="$HOME/.cache/setup.cache"
    sed -i "1s/.*/$PACMAN_HASH/" "$gensumcache"
    sed -i "3s/.*/$AUR_HASH/" "$gensumcache"
fi
