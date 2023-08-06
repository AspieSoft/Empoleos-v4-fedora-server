#!/bin/bash

#!NON-SERVER/DESKTOP-ONLY

dir="$PWD"

bash "$dir/bin/scripts/theme/core-extensions-config.sh"

# move gnome core extensions to root
sudo mv $HOME/.local/share/gnome-shell/extensions/* /usr/share/gnome-shell/extensions
for file in $(ls /usr/share/gnome-shell/extensions); do
  sudo -R root:root "/usr/share/gnome-shell/extensions/$file"
done

bash "$dir/bin/scripts/theme/user-extensions.sh"
