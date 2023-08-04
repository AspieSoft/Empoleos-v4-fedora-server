#!/bin/bash

# config gnome user extension

# - burn my windows
mkdir -p "~/.config/burn-my-windows/profiles"
cp ./bin/assets/extensions/burn-my-windows.conf "~/.config/burn-my-windows/profiles"
gsettings --schemadir ~/.local/share/gnome-shell/extensions/burn-my-windows@schneegans.github.com/schemas/ set org.gnome.shell.extensions.burn-my-windows active-profile "~/.config/burn-my-windows/profiles/burn-my-windows.conf"

# other config options
gsettings set org.gnome.TextEditor restore-session "false"
