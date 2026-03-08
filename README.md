## My Dotfiles

TODO:
Make hash thing better
also move sh to script dir

### NOTICE ###
The archive folder will have old config</br>
for stuff I don't currently use anymore

> [!TIP]
> All of your current config will be backed up in `backup/`</br>
> and the launch.sh waybar script will auto detect your motitor width
> so everything fits! :D

### Install
> [!IMPORTANT]
> setup script is ment for new arch machines</br>
> As of now it only has arch support </br>
> also yay is alias for paru

**ARCH**
1. Run the makefile `make`
This will install dependencies too and backup current config</br>
and thats it!

**NIXOS**
1. Include the flake in your configuration
2. run the `flake.sh` script in the `scripts/` folder
