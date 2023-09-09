#!/bin/bash

#!NON-SERVER/DESKTOP-ONLY

dir="$PWD"

source "$dir/bin/scripts/theme/core-extensions-config.sh" "$dir"

# move gnome core extensions to root
sudo mv $HOME/.local/share/gnome-shell/extensions/* /usr/share/gnome-shell/extensions
for file in $(ls /usr/share/gnome-shell/extensions); do
  sudo chown -R root:root "/usr/share/gnome-shell/extensions/$file"
done

source "$dir/bin/scripts/theme/user-extensions.sh" "$dir"
