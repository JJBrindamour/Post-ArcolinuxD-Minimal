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
sudo pacman -S pipewire pipewire-pulse pipewire-alsa pipewire-jack pamixer obconf ttf-font-awesome ttf-nerd-fonts-mono lxappearance kvantum grub-customizer openbox bspwm sxhkd sddm alacritty vim nano micro thunar geany sddm zsh picom xfce4-power-manager xfce4-settings dunst wget neofetch nitrogen plank polybar ranger rofi starship firefox arandr carla flatpak wine

# Install Yay
git clone https://aur.archlinux.com/yay.git "$HOME"/yay
(cd "$HOME"/yay && makepkg -si)

# Install AUR Packages
yay -S betterlockscreen spotify cava networkmanager-dmenu-git papirus-folders-nordic

# Install Configs
for custom in ./.config/*; do
	for preinstalled in "$HOME"/.config/*; do
		if [[ $(basename $custom) == $(basename $preinstalled) ]]; then rm -rf preinstalled; fi
	done
done

mv ./.config/* "$HOME"/.config/
mv ./.bashrc "$HOME"/.bashrc
mv ./.zshrc "$HOME"/.zshrc
mv ./.gtkrc-2.0 "$HOME"/.gtkrc-2.0
mv ./.xinitrc "$HOME"/.xinitrc

# Betterlockscreen
betterlockscreen -u "$HOME"/.config/wallpaper.jpg

# Nitrogen
echo "[xin_0]
file=${HOME}/.config/wallpaper.jpg
mode=0
bgcolor=#000000

[xin_1]
file=${HOME}/.config/wallpaper.jpg
mode=0
bgcolor=#000000" >> "$HOME"/.config/nitrogen/bg-saved.cfg

echo "dirs=${HOME}/.config/wallpapers;" >> "$HOME"/.config/nitrogen/nitrogen.cfg

# Openbox & GTK Theme
git clone https://github.com/archcraft-os/archcraft-themes.git "$HOME"/archcraft-themes
mkdir -p /usr/share/themes
sudo mv "$HOME"/archcraft-themes/archcraft-gtk-theme-nordic/files/Nordic /usr/share/themes/

# Reboot
sudo reboot

