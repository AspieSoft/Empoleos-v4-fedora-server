#!/bin/bash

#!NON-SERVER/DESKTOP-ONLY

# config gnome user extension

# - burn my windows
mkdir -p "~/.config/burn-my-windows/profiles"
cp ./bin/assets/extensions/burn-my-windows.conf "~/.config/burn-my-windows/profiles"
gsettings --schemadir ~/.local/share/gnome-shell/extensions/burn-my-windows@schneegans.github.com/schemas/ set org.gnome.shell.extensions.burn-my-windows active-profile "~/.config/burn-my-windows/profiles/burn-my-windows.conf"


# other config options
gsettings set org.gnome.TextEditor restore-session "false"


bash "./bin/scripts/fix-keyboard-shortcuts.sh"


# copy extension settings for new users
sudo mkdir -p "/etc/skel/.local/share/gnome-shell/extensions"
sudo mkdir -p "/etc/skel/.config"
sudo cp -rf "$HOME/.local/share/gnome-shell/extensions" "/etc/skel/.local/share/gnome-shell/extensions"
sudo cp -rf "$HOME/.config/burn-my-windows" "/etc/skel/.config"
