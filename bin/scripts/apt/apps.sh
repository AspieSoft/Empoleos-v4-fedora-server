#!/bin/bash

dir="$1"

#todo: test if apps is configured correctly for apt (replacing dnf)

sudo apt -y install nemo
sudo apt -y install nemo-fileroller
xdg-mime default nemo.desktop inode/directory application/x-gnome-saved-search

if test -d "/usr/share/applications"; then
  sudo sed -r -i 's/^OnlyShowIn=/#OnlyShowIn=/m' "/usr/share/applications/nemo.desktop"
  sudo sed -r -i 's#^inode/directory=(.*)$#inode/directory=nemo.desktop#m' "/usr/share/applications/gnome-mimeapps.list"
  git clone https://github.com/AspieSoft/linux-nemo-fix.git && ./linux-nemo-fix/install.sh
fi

sudo flatpak -y install flathub com.github.tchx84.Flatseal
sudo apt -y install dconf-editor gnome-tweaks gnome-shell-extensions
killall gnome-tweaks # this can fix the app if it will not open
# sudo flatpak -y install flathub org.gnome.Extensions
sudo flatpak -y install flathub com.mattjakeman.ExtensionManager
# sudo snap install gnome-extension-manager
sudo apt -y install gnome-disk-utility
sudo apt -y install gparted
sudo apt -y install gnome-boxes
# sudo flatpak -y install flathub org.fedoraproject.MediaWriter
wget -O "$HOME/Desktop/Etcher" https://github.com/balena-io/etcher/releases/download/v1.18.11/balenaEtcher-1.18.11-x64.AppImage
sudo mkdir -p /etc/skel/Desktop
sudo cp "$HOME/Desktop/Etcher" /etc/skel/Desktop/

# install text editor
sudo apt -y install gedit

# install photo viewer
sudo apt -y remove gnome-photos
sudo apt -y install shotwell

# install music player
sudo apt -y install rhythmbox

# install video player
sudo apt -y remove totem
sudo apt -y remove mpv
sudo apt -y install celluloid

# install calendar
sudo apt -y remove evolution
sudo apt -y install gnome-calendar

# install browser
#todo: add option of browser choice
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo rm -f google-chrome-stable_current_amd64.deb
# sudo apt -y install chromium
# sudo apt -y install firefox

#todo: find alternative webcam app with better quality (OBS studio can also handle webcams with much better quality)
# install webcam app
# sudo flatpak -y install flathub org.gnome.Snapshot # may be under development and so far bad quality on my laptop


# install common tools
sudo apt -y install blender
sudo apt -y install gimp
sudo apt -y install pinta
sudo snap install video-downloader
sudo apt -y install audacity
sudo apt -y install nm-connection-editor
sudo apt -y install obs-studio
sudo apt -y install shotcut

# install other important apps
sudo apt -y install gnome-system-monitor
sudo apt -y install gnome-characters
sudo apt -y install gnome-calculator
sudo apt -y install gnome-clocks
# sudo apt -y install gnome-connections
sudo apt -y install gnome-contacts
sudo apt -y install evince # document viewer
sudo apt -y install simple-scan # document scanner
sudo apt -y install gnome-font-viewer
sudo apt -y install gnome-logs
sudo apt -y install gnome-screenshot

sudo apt -y install gnome-maps
sudo apt -y install gnome-weather

sudo apt -y install gnome-power-manager


# install steam
sudo apt -y install steam

# hide steam folder
if ! grep -q "Steam" "$HOME/.hidden" ; then
  echo "Steam" | sudo tee -a "$HOME/.hidden"
fi
if ! grep -q "Steam" "/etc/skel/.hidden" ; then
  echo "Steam" | sudo tee -a "/etc/skel/.hidden"
fi

#todo: will need to add a script to run when new users are created, to automatically create a user specific steam folder in the "/games" directory
# may use symlinks to make steam games always use "/games" folder by default

# ensure root games directory exists
if ! test -d "/games"; then
  sudo mkdir "/games"
fi

# add games folder for user
sudo mkdir "/games/$USER"
sudo chown "$USER:$USER" "/games/$USER"
sudo chmod -R 700 "/games/$USER"
sudo ln -s /games/$USER "$HOME/.games"

# link steam dirs to .games
mkdir "$HOME/.games/Steam"

function linkSteamDir {
  if ! test -d "$HOME/.local/share/Steam/$1"; then
    mkdir -p "$HOME/.local/share/Steam/$1"
  fi
  mv "$HOME/.local/share/Steam/$1" "$HOME/.games/Steam/$1"
  ln -s "$HOME/.games/Steam/$1" "$HOME/.local/share/Steam/$1"
}

linkSteamDir "steamapps"
linkSteamDir "steam"
linkSteamDir "servers"
linkSteamDir "appcache"
linkSteamDir "depotcache"
linkSteamDir "package"
linkSteamDir "linux64"
linkSteamDir "linux32"
linkSteamDir "ubuntu12_64"
linkSteamDir "ubuntu12_32"
linkSteamDir "legacycompat"
linkSteamDir "graphics"

sudo cp "$dir/bin/assets/adduser.local" "/usr/local/sbin"
