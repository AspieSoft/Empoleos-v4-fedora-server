#!/bin/bash

ServerMode="$1"
dir="$PWD"

sudo apt -y update
sudo apt -y upgrade

sudo dpkg --configure -a

# add repos
# sudo apt -y install ubuntu-restricted-extras
sudo apt-add-repository -y multiverse
sudo apt-add-repository -y universe
sudo apt-add-repository -y ppa:obsproject/obs-studio
sudo apt-add-repository -y ppa:cybermax-dexter/sdl2-backport
sudo apt-add-repository -y ppa:pinta-maintainers/pinta-stable

sudo apt -y update

# optimize package manager
# sudo apt -y install nala
# echo -e "\n" | sudo nala fetch
# sudp cp "$dir/bin/assets/nala.sh" /etc/profile.d


# install ufw (firewall)
sudo apt -y install ufw
sudo systemctl enable ufw --now
sudo ufw delete allow SSH
sudo ufw delete allow to 244.0.0.251 app mDNS
sudo ufw delete allow to ff02::fb app mDNS
echo -e "y\n" | sudo ufw delete 1

if [ "$ServerMode" = "y" ]; then
  sudo ufw limit 22/tcp
  sudo ufw allow 80/tcp
  sudo ufw allow 443/tcp
fi

sudo ufw default deny incoming
sudo ufw default allow outgoing

sudo ufw enable

# cleanup
sudo apt -y update
sudo apt -y autoremove
sudo apt -y autoclean

# install media codecs
sudo apt -y install ffmpeg
sudo apt -y install webp libwebp-dev
sudo add-apt-repository -y ppa:helkaluin/webp-pixbuf-loader
sudo apt -y install webp-pixbuf-loader

# add flatpak
sudo apt -y install flatpak
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak update -y --noninteractive

# install snap
sudo apt -y install snapd
sudo ln -s /var/lib/snapd/snap /snap
sudo systemctl enable snapd --now
sudo snap refresh #fix: not seeded yet will trigger and fix itself for the next command
sudo snap install core
sudo snap refresh core
sudo snap refresh

# cleanup
sudo apt -y update
sudo apt -y autoremove
sudo apt -y autoclean

# install shortcuts
if ! [ -f "/etc/profile.d/empoleos.sh" ]; then
  sudo cp "$dir/bin/assets/empoleos-shortcuts.apt.sh" "/etc/profile.d/empoleos.sh"
fi

# run install scripts
bash "$dir/bin/scripts/apt/preformance.sh" "$dir"
bash "$dir/bin/scripts/apt/fix.sh" "$dir"
bash "$dir/bin/scripts/apt/langs.sh" "$dir"
bash "$dir/bin/scripts/apt/security.sh" "$dir"

# run non-server desktop install scripts
if ! [ "$ServerMode" = "y" ]; then
  if [ "$(cat /etc/os-release | grep '^NAME="Zorin OS"' 2>/dev/null)" != "" ]; then
    bash "$dir/bin/scripts/apt/desktop.sh" "$dir"
  fi
  bash "$dir/bin/scripts/desktop-security.sh" "$dir"

  # install common apps
  bash "$dir/bin/scripts/apt/apps.sh" "$dir"

  # install optional
  #todo: make optional
  bash "$dir/bin/scripts/extras/wine.apt.sh" "$dir"
  bash "$dir/bin/scripts/extras/developer.apt.sh" "$dir"
  bash "$dir/bin/scripts/extras/office.sh" "$dir"

  # install theme
  bash "$dir/bin/scripts/theme/config.sh" "$dir"
  bash "$dir/bin/scripts/theme/core-extensions.sh" "$dir"
fi
