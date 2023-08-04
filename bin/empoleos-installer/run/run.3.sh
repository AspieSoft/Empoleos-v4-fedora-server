#!/bin/bash

#!NON-SERVER/DESKTOP-ONLY

bash "./bin/scripts/theme/user-extensions-config.sh"

bash "./bin/scripts/fix-keyboard-shortcuts.sh"

# copy extension settings for new users
sudo mkdir -p "/etc/skel/.local/share/gnome-shell/extensions"
sudo mkdir -p "/etc/skel/.config"
sudo cp -rf "$HOME/.local/share/gnome-shell/extensions" "/etc/skel/.local/share/gnome-shell/extensions"
sudo cp -rf "$HOME/.config/burn-my-windows" "/etc/skel/.config"
