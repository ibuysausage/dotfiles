#!/bin/bash

read -p "Would you like to install hyprland?: (y/n) " hypr
if [ $hypr == "y" ]; then
    yay -S $(cat dependencies/hyprland-arch.txt)
fi


read -p "Are you using debian?: (y/n) " debian
if [ $debian == "y" ]; then
    sudo apt update && sudo apt upgrade
    sudo apt install $(cat dependencies/basic-debian.txt)
    curl -OL https://github.com/fastfetch-cli/fastfetch/releases/download/2.59.0/fastfetch-linux-amd64.deb
    curl -OL https://github.com/junegunn/fzf/releases/download/v0.68.0/fzf-0.68.0-linux_amd64.tar.gz && tar -xvf fzf-0.68.0-linux_amd64.tar.gz 
    sudo mv fzf /usr/local/bin
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
    
    echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
    sudo apt update && sudo apt install glow
    sudo apt install ./fastfetch-linux-amd64.deb
fi

if [ $debian == "n" ]; then
    sudo pacman -S $(cat dependencies/basic-arch.txt)
fi

curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz
tar -xvf JetBrainsMono.tar.xz && sudo mkdir /usr/share/fonts/JetBrainsMono/
sudo mv *.ttf /usr/share/fonts/JetBrainsMono/
fc-cache -frv && rm JetBrainsMono.tar.xz
stow kitty --adopt
stow vim --adopt
stow zsh --adopt

rm -rf fastfetch*
rm -rf fzf*
rm -rf OFL.txt
git reset --hard HEAD

if [ $hypr == "y" ]; then
    stow hyprland --adopt
    sudo mkdir /usr/share/icons/FontAwesome
    sudo cp icons/* /usr/share/icons/FontAwesome
    sudo rm -rf /etc/xdg/waybar/ && sudo rm -rf /etc/rofi/
    sudo rm -rf /etc/dunst/
fi

cd $HOME && git clone https://github.com/romkatv/powerlevel10k.git
mkdir -p $HOME/.config/systemd/user/
cp spotify-notify.service $HOME/.config/systemd/user/
systemctl --user daemon-reload
systemctl --user enable --now spotify-notify.service
systemctl --user enable spotify-notify.service
systemctl --user start spotify-notify.service
bash <(curl -sSL https://spotx-official.github.io/run.sh)


if [ $hypr == "y" ]; then
    git clone --recursive https://github.com/hyprwm/Hyprland
    cd Hyprland
    make all && sudo make install
fi

echo "Done!"
echo "To see effects close your terminal and open up kitty to see the effects"
