#!/bin/bash

ServerMode="$1"
package_manager="$2"
dir="$PWD"

# install auto updates
if [ "$ServerMode" = "y" ]; then
  sudo sed -r -i 's/^#ServerMode=$/ServerMode=/m' "$dir/bin/apps/empoleos/update.sh"
fi
sudo cp -rf "$dir/bin/assets/empoleos" "/etc"
sudo rm -f "/etc/empoleos/empoleos.service"
sudo cp -f "$dir/bin/assets/empoleos/empoleos.service" "/etc/systemd/system"
gitVer="$(curl --silent 'https://api.github.com/repos/AspieSoft/Empoleos/releases/latest' | grep '\"tag_name\":' | sed -E 's/.*\"([^\"]+)\".*/\1/')"
echo "$gitVer" | sudo tee "/etc/empoleos/version.txt"

sudo systemctl daemon-reload
sudo systemctl enable empoleos.service --now


# go back to default power mode
sudo powerprofilesctl set preformance # fallback incase balanced mode does not exist
sudo powerprofilesctl set balanced


# wait until end to enable gdm
if ! [ "$ServerMode" = "y" ]; then
  if [ "$package_manager" = "apt" ]; then
    if ! [ "$(cat /etc/os-release | grep '^NAME="Zorin OS"' 2>/dev/null)" != "" ]; then
      sudo systemctl set-default graphical.target
      sudo systemctl enable gdm3
    fi
  else
    sudo systemctl set-default graphical.target
    sudo systemctl enable gdm
  fi
fi
