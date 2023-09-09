#!/bin/bash

dir="$1"

# install gdm (login manager / display manager)
sudo apt -y install gdm3

# install wayland (window manager / display server)
sudo apt -y install xwayland

# install gnome
sudo apt -y install gnome-shell
sudo apt -y install gnome-session
sudo apt -y install gnome-software
sudo apt -y install gnome-terminal
sudo apt -y install fonts-cantarell
sudo apt -y install adwaita-icon-theme

# install jetbrains font
FONT_VERSION=$(curl -s "https://api.github.com/repos/JetBrains/JetBrainsMono/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')
curl -sSLo jetbrains-mono.zip https://download.jetbrains.com/fonts/JetBrainsMono-$FONT_VERSION.zip
unzip -qq jetbrains-mono.zip -d jetbrains-mono
sudo mkdir /usr/share/fonts/truetype/jetbrains-mono
sudo mv jetbrains-mono/fonts/ttf/*.ttf /usr/share/fonts/truetype/jetbrains-mono
rm -rf jetbrains-mono.zip jetbrains-mono

# config
echo -e "\n" | sudo update-alternatives --config gdm3-theme.gresource

# fix compatability
sudo apt -y install plasma-framework

# setup gdm config
sudo sed -r -i 's/^#WaylandEnable=(.*)$/WaylandEnable=true/m' "/etc/gdm3/custom.conf"

# enable gdm
#todo: may wait until end to run this (/bin/empoleos-init/run/run.5.sh)
# sudo systemctl set-default graphical.target
# sudo systemctl enable gdm
