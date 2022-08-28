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
sudo pacman -S pipewire pipewire-pulse pipewire-alsa pipewire-jack pamixer obconf lxappearance kvantum grub-customizer gpick openbox bspwm sxhkd sddm alacritty vim nano micro thunar geany sddm zsh picom xfce4-power-manager xfce4-settings dunst wget neofetch nitrogen plank polybar ranger rofi starship firefox light arandr carla flatpak wine betterlockscreen spotify cava

# Install Yay
#git clone https://aur.archlinux.org/yay.git "$HOME"/yay
#(cd "$HOME"/yay && makepkg -si)

# Install AUR Packages
yay -S numix-circle-icon-theme-git networkmanager-dmenu-git xfce-polkit obmenu-generator nerd-fonts-fira-code # betterlockscreen spotify cava papirus-folders-nordic # IN ARCO REPOS

# Install Configs
mv "$HOME"/.config "$HOME"/.config-backup
mv "$HOME"/.bashrc "$HOME"/.bashrc-backup
mv "$HOME"/.zshrc "$HOME"/.zshrc-backup
mv "$HOME"/.gtkrc-2.0 "$HOME"/.gtkrc-2.0-backup
mv "$HOME"/.xinitrc "$HOME"/.xinitrc-backup

mv ./.config "$HOME"/
mv ./.bashrc "$HOME"/
mv ./.zshrc "$HOME"/
mv ./.gtkrc-2.0 "$HOME"/
mv ./.xinitrc "$HOME"/

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

