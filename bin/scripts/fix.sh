#!/bin/bash

dir="$1"

# install common packages
sudo dnf -y install nano
sudo dnf -y install neofetch

# install file systems
sudo dnf -y install btrfs-progs lvm2 xfsprogs udftools

# install 7zip
sudo dnf -y install p7zip p7zip-plugins

# install printer software
sudo dnf -y install hplip hplip-gui

# install inotify-tools
sudo dnf -y install inotify-tools

# hide core files
if ! [ -f "$HOME/.hidden" ]; then
  sudo touch "$HOME/.hidden"
fi

if ! grep -q "core" "$HOME/.hidden" ; then
  echo "core" | sudo tee -a "$HOME/.hidden"
fi
if ! grep -q "snap" "$HOME/.hidden" ; then
  echo "snap" | sudo tee -a "$HOME/.hidden"
fi

# hide core files for new users
if ! [ -f "/etc/skel/.hidden" ]; then
  sudo touch "/etc/skel/.hidden"
fi

if ! grep -q "core" "/etc/skel/.hidden" ; then
  echo "core" | sudo tee -a "/etc/skel/.hidden"
fi
if ! grep -q "snap" "/etc/skel/.hidden" ; then
  echo "snap" | sudo tee -a "/etc/skel/.hidden"
fi

# fix webcam and mic access for apps
sudo dnf -y install guvcview
sudo modprobe -r uvcvideo && sudo modprobe uvcvideo

if ! [ -f "$HOME/.bash_profile" ]; then
  sudo touch "$HOME/.bash_profile"
fi

if ! grep -q "export QT_QPA_PLATFORM=wayland" "$HOME/.bash_profile" ; then
  echo "export QT_QPA_PLATFORM=wayland" | sudo tee -a "$HOME/.bash_profile"
fi

if ! [ -f "/etc/skel/.bash_profile" ]; then
  sudo touch "/etc/skel/.bash_profile"
fi

if ! grep -q "export QT_QPA_PLATFORM=wayland" "/etc/skel/.bash_profile" ; then
  echo "export QT_QPA_PLATFORM=wayland" | sudo tee -a "/etc/skel/.bash_profile"
fi
