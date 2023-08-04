#!/bin/bash

#? global dnf install
sudo dnf -y install gdm wayland-devel gnome-shell gnome-session gnome-software gnome-terminal plasma-framework


# install gdm (login manager / display manager)
# sudo dnf -y install gdm

# install wayland (window manager / display server)
# sudo dnf -y install wayland-devel

# install gnome
# sudo dnf -y install gnome-shell
# sudo dnf -y install gnome-session
# sudo dnf -y install gnome-software
# sudo dnf -y install gnome-terminal
sudo dnf -y install abattis-cantarell-fonts
sudo dnf -y install adwaita-icon-theme

# config
sudo update-alternatives --config gdm3-theme.gresource

# fix compatability
# sudo dnf -y install plasma-framework

# setup gdm config
sudo sed -r -i 's/^#WaylandEnable=(.*)$/WaylandEnable=true/m' "/etc/gdm/custom.conf"

# enable gdm
#todo: may wait until end to run this (/bin/empoleos-init/run/run.5.sh)
# sudo systemctl set-default graphical.target
# sudo systemctl enable gdm
