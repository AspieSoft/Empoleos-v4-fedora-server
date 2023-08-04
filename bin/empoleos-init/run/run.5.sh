#!/bin/bash

ServerMode="$1"

# install auto updates
if [ "$ServerMode" = "y" ]; then
  sudo sed -r -i 's/^#ServerMode=$/ServerMode=/m' "$dir/bin/apps/empoleos/update.sh"
fi
sudo cp -rf "./bin/assets/empoleos" "/etc"
sudo rm -f "/etc/empoleos/empoleos.service"
sudo cp -f "./bin/assets/empoleos/empoleos.service" "/etc/systemd/system"
gitVer="$(curl --silent 'https://api.github.com/repos/AspieSoft/Empoleos/releases/latest' | grep '\"tag_name\":' | sed -E 's/.*\"([^\"]+)\".*/\1/')"
echo "$gitVer" | sudo tee "/etc/empoleos/version.txt"

sudo systemctl daemon-reload
sudo systemctl enable empoleos.service --now
