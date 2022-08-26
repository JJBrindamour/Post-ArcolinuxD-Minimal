#!/bin/bash

# Prevent running with sudo
if [[ $(id -u) == 0 ]]; then
	echo "This script should not be run as root, or a superuser"
	exit
fi

# Update the system
sudo pacman -S archlinux-keyring
sudo pacman -Syyu

# Install Pacman Packages
sudo pacman -S pipewire pipewire-pulse pipewire-alsa pipewire-jack pamixer lxappearance kvantum grub-customizer openbox bspwm sxhkd sddm alacritty vim nano micro thunar geany sddm zsh dunst wget neofetch nitrogen plank polybar ranger rofi starship firefox arandr carla flatpak wine

# Install Yay
git clone https://aur.archlinux.com/yay.git "$HOME"/yay
(cd "$HOME"/yay && makepkg -si)

# Install AUR Packages
yay -S betterlockscreen spotify cava github-desktop networkmanager-dmenu-git papirus-folders-nordic

# Install Configs
for custom in ./.config/*; do
	for preinstalled in "$HOME"/.config/*; do
		if [[ $(basename $custom) == $(basename $preinstalled) ]]; then rm -rf preinstalled; fi
	done
done

mv ./.config/* "$HOME"/.config/
mv .bashrc "$HOME"/.bashrc
mv .zshrc "$HOME"/.zshrc
mv .gtkrc-2.0 "$HOME"/.gtkrc-2.0

# Betterlockscreen
betterlockscreen -u "$HOME"/.config/wallpaper.jpg

# Openbox & GTK Theme
git clone https://github.com/archcraft-os/archcraft-themes.git "$HOME"/archcraft-themes
sudo mv "$HOME"/archcraft-themes/archcraft-gtk-theme-nordic/files/Nordic/* /usr/share/themes/nordic/

# Reboot
sudo reboot

