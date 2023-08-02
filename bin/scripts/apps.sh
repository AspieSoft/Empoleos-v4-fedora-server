#!/bin/bash

sudo dnf -y install nemo
sudo dnf -y install nemo-fileroller
xdg-mime default nemo.desktop inode/directory application/x-gnome-saved-search

if test -d "$rDir/usr/share/applications"; then
  sudo sed -r -i 's/^OnlyShowIn=/#OnlyShowIn=/m' "/usr/share/applications/nemo.desktop"
  sudo sed -r -i 's#^inode/directory=(.*)$#inode/directory=nemo.desktop#m' "/usr/share/applications/gnome-mimeapps.list"
  sudo chattr +i "/usr/share/applications/nemo.desktop" # prevent updates from changing this file
fi
