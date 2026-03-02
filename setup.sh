#!/bin/bash

# Current dir
dotdir=`pwd`

# Update pkgs
sudo pacman -Syu --noconfirm

#Install script runtime deps
sudo pacman -S gum base-devel --noconfirm
pip install chardet lib3 datetime requests statistics urllib3 dulwich --break-system-packages

# Install paru
if [[ ! -f /usr/bin/paru ]]; then
    pushd $HOME; git clone https://aur.archlinux.org/paru.git
    cd paru/; makepkg -si; popd
fi

# Install hyprland deps
clear
hypr=1
if gum confirm "Would you like to install hyprland?"; then
    hypr=0
    aurdeps=`cat dependencies/aur-arch.txt`
    if [[ ! -f $HOME/.cache/aurdeps.cache ]]; then
        paru -S $aurdeps --noconfirm
        touch $HOME/.cache/aurdeps.cache
        paruinstall="YES"
    else
        paru --noconfirm
    fi
fi

# Remove packaged rust
if [[ $paruinstall == "YES"  ]]; then
  paru -R rust --noconfirm
fi

# Install basic deps
archdeps=`cat dependencies/basic-arch.txt`
sudo pacman -S $archdeps --noconfirm

# Install non pkg dependencies
nonpkgdeps() {
    # Rust & Other & Fonts
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    curl -LO https://github.com/clippyricer/dotfiles/releases/download/v0.1.0/assets.tar; tar -xvf assets.tar

    curl -LO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz
    if [ ! -d "/usr/share/fonts/JetBrainsMono" ]; then
        sudo mkdir -p /usr/share/fonts/JetBrainsMono/
    fi

    fontdir="/usr/share/fonts/JetBrainsMono/"
    sudo tar -xvf JetBrainsMono.tar.xz -C $fontdir; rm -rf JetBrainsMono.tar.xz
    cd $fontdir; sudo rm -rf *.md *.txt
    cd $dotdir
    fc-cache -frv


    # Oh-My-Posh
    curl -s https://ohmyposh.dev/install.sh | bash -s
    cd ~/.local/bin
    sudo mv oh-my-posh /usr/local/bin
    cd $dotdir
}

nonpkgdeps

# Backup current config
mkdir -p backup/config/

for backupdir in *; do
    if [[ -d $backupdir && ! $backupdir == "dependencies" && ! $backupdir == "hyprland" && ! $backupdir == "release" && ! $backupdir == "archive"  && ! $backupdir == "backup" && ! $backupdir == "icons" && ! $backupdir == "other" && ! $backupdir == "wallpapers" ]]; then
        if [[ -d $HOME/.config/$backupdir ]]; then
            cp -r $HOME/.config/$backupdir $dotdir/backup/config/
        fi
    fi
done

if [ -f $HOME/.vimrc ]; then
    cp $HOME/.vimrc $dotdir/backup/vimrc
fi

if [ -f $HOME/.p10k.zsh ]; then
    cp $HOME/.p10k.zsh $dotdir/backup/p10k.zsh
fi

if [ -f $HOME/.zshrc ]; then
    cp $HOME/.zshrc $dotdir/backup/zshrc
fi

# Backup hyprland config
clear
if [ $hypr == 0 ]; then
    echo "I will ask you questions. If you don't use what I ask you about"
    echo "leave it blank. Make sure to specify FULL path ex(/home/user/.config/dunst)"
    sleep 4
    echo ""
    read -p "Input your dunst config path: " dunstpath
    read -p "Input your hyprland config path: " hyprpath
    read -p "Input your rofi config path: " rofipath
    read -p "Input your waybar config path: " waybarpath
    echo ""
    
    if [[ ! $dunstpath == "" ]]; then
        cp -r $dunstpath $dotdir/backup/config/
    fi

    if [[ ! $hyprpath == "" ]]; then
        cp -r $hyprpath $dotdir/backup/config/
    fi

    if [[ ! $rofipath == "" ]]; then
        cp -r $rofipath $dotdir/backup/config/
    fi

    if [[ ! $waybarpath == "" ]]; then
        cp -r $waybarpath $dotdir/backup/config/
    fi
fi

# Initlize config
cd $dotdir
for dir in *; do
    if [[ -d $dir && ! $dir == "dependencies" && ! $dir == "hyprland" && ! $dir == "release" && ! $dir == "archive" && ! $dir == "backup" && ! $dir == "icons" && ! $dir == "other" && ! $dir == "wallpapers" ]]; then
        echo "Applying config for $dir"
        stow -D $dir 
        stow $dir --adopt
    fi
done

cd $dotdir

# Install icons for hyprland & wallpapers
if [ $hypr == 0 ]; then
    stow hyprland --adopt
    if [ ! -d "/usr/share/icons/FontAwsome" ]; then
        sudo mkdir -p /usr/share/icons/FontAwesome; icons="/usr/share/icons/FontAwesome/"
    fi
    sudo cp icons/* $icons
    mkdir -p $HOME/Pictures/Wallpapers; cp wallpapers/* $HOME/Pictures/Wallpapers
fi

# Install spotify
sudo cp other/spotify-notify /usr/local/bin

if [ ! -d "$HOME/.config/systemd/user" ]; then
    mkdir -p $HOME/.config/systemd/user/
fi

cd $dotdir
cp other/spotify-notify.service $HOME/.config/systemd/user/

systemctl --user daemon-reload; systemctl --user enable --now spotify-notify.service
systemctl --user enable spotify-notify.service; systemctl --user start spotify-notify.service


# Install Hyprland
if [ $hypr == 0 ]; then
    if [ ! -d "$HOME/Hyprland" ]; then
        git clone --recursive https://github.com/hyprwm/Hyprland; cd Hyprland/
    else
        cd $HOME/Hyprland; git pull --force
    fi

    mkdir build; cd build/
    cmake -G Ninja ..; sudo ninja && sudo ninja install
    systemctl enable ly@tty1.service; systemctl disable getty@tty1.service
    rustup override set stable || exit -1; rustup update stable; git clone https://github.com/coffebar/waybar-module-pacman-updates.git /tmp/waybar-module-pacman-updates
    pushd /tmp/waybar-module-pacman-updates && cargo build --release; mkdir -p ~/.local/bin; cp target/release/waybar-module-pacman-updates ~/.local/bin/
    popd && rm -rf /tmp/waybar-module-pacman-updates 
fi

cd $HOME

# Options
read -p "Would you like to install the minegrub bootloader theme?: (y/n) " minegrub
read -p "Would you like to install Spotify add block?: (y/n) " spotx
read -p "Would you like to install Ly configuration?: (y'n) " ly

if [[ $minegrub == "Y" || $minegrub == "y" ]]; then
    git clone https://github.com/Lxtharia/double-minegrub-menu.git /tmp/double-minegrub-menu; pushd /tmp/double-minegrub-menu
    sudo ./install.sh
    popd
fi

if [[ $ly == "y" || $ly == "Y" ]]; then
    sudo git clone https://github.com/clippyricer/ly-config.git /etc/ly
fi

if [[ $spotx == "y" || $spotx == "Y" ]]; then
    cd $HOME; bash <(curl -sSL https://spotx-official.github.io/run.sh)
fi

if [ $hypr == 0 ]; then
    git clone https://codeberg.org/LGFae/awww.git /tmp/awww
    pushd /tmp/awww; cargo build --release
    sudo cp target/release/awww /usr/local/bin; sudo cp target/release/awww-daemon /usr/local/bin
    ./doc/gen.sh; sudo cp doc/generated* /usr/share/man
fi

clear
echo "Done!"
echo "To see effects close your terminal and open up kitty to see the effects"
