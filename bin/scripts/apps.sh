#!/bin/bash

sudo dnf -y install nemo
sudo dnf -y install nemo-fileroller
xdg-mime default nemo.desktop inode/directory application/x-gnome-saved-search

if test -d "$rDir/usr/share/applications"; then
  sudo sed -r -i 's/^OnlyShowIn=/#OnlyShowIn=/m' "/usr/share/applications/nemo.desktop"
  sudo sed -r -i 's#^inode/directory=(.*)$#inode/directory=nemo.desktop#m' "/usr/share/applications/gnome-mimeapps.list"
  sudo chattr +i "/usr/share/applications/nemo.desktop" # prevent updates from changing this file
fi

#todo: install common apps for viewing images, videos, text, etc.

sudo dnf -y install chromium

sudo flatpak -y install flathub com.github.tchx84.Flatseal
sudo dnf -y install dconf-editor gnome-tweaks gnome-extensions-app
killall gnome-tweaks # this can fix the app if it will not open
sudo flatpak -y install flathub org.gnome.Extensions
sudo flatpak -y install flathub com.mattjakeman.ExtensionManager
sudo dnf-y install gparted

# install steam
sudo dnf -y module disable nodejs
sudo dnf -y install steam
sudo dnf -y module install -y --allowerasing nodejs:16/development

# hide steam folder
if ! grep -q "Steam" "$HOME/.hidden" ; then
  echo "Steam" | sudo tee -a "$HOME/.hidden"
fi
if ! grep -q "Steam" "/etc/skel/.hidden" ; then
  echo "Steam" | sudo tee -a "/etc/skel/.hidden"
fi

#todo: will need to add a script to run when new users are created, to automatically create a user specific steam folder in the "/games" directory
# may use symlinks to make steam games always use "/games" folder by default


#todo: put other less common apps in an optional "extras.sh" file
# may add seperate file for developer extras (may also include subfolder for different types of extras)

# may consider using snap for vscode (even in fedora)
