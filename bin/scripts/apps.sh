#!/bin/bash

sudo dnf -y install nemo
sudo dnf -y install nemo-fileroller
xdg-mime default nemo.desktop inode/directory application/x-gnome-saved-search

if test -d "$rDir/usr/share/applications"; then
  sudo sed -r -i 's/^OnlyShowIn=/#OnlyShowIn=/m' "/usr/share/applications/nemo.desktop"
  sudo sed -r -i 's#^inode/directory=(.*)$#inode/directory=nemo.desktop#m' "/usr/share/applications/gnome-mimeapps.list"
  # sudo chattr +i "/usr/share/applications/nemo.desktop" # prevent updates from changing this file
  git clone https://github.com/AspieSoft/linux-nemo-fix.git && ./linux-nemo-fix/install.sh
fi

sudo flatpak -y install flathub com.github.tchx84.Flatseal
sudo dnf -y install dconf-editor gnome-tweaks gnome-extensions-app
killall gnome-tweaks # this can fix the app if it will not open
sudo flatpak -y install flathub org.gnome.Extensions
sudo flatpak -y install flathub com.mattjakeman.ExtensionManager
sudo dnf -y install gparted
sudo dnf -y install gnome-boxes
sudo flatpak -y install flathub org.fedoraproject.MediaWriter


# install text editor
sudo dnf -y install gnome-text-editor
# sudo flatpak -y install flathub org.xfce.mousepad # no syntax highlighting

# install photo viewer
sudo dnf -y install shotwell
# sudo dnf -y install gnome-photos # shotwell can open webp files
# sudo dnf -y install gpicview # crashes in gnome
# sudo dnf -y install gwenview # looks a bit outdated
# sudo dnf -y install eog # no different than gnome

# install music player
sudo dnf -y install rhythmbox # may be able to add an extension
# plugin did not seem to make any difference
# dnf copr enable mochaa/rhythmbox-alternative-toolbar
# sudo dnf -y install rhythmbox-alternative-toolbar

# install video player
sudo dnf -y install celluloid
# sudo flatpak -y install flathub org.gnome.Totem # celluloid was just awesome

# install calendar
sudo dnf install gnome-calendar

# install browser
#todo: add option of browser choice
sudo dnf -y install google-chrome-stable
# sudo dnf -y install chromium
# sudo dnf -y install firefox

#todo: find alternative webcam app with better quality (OBS studio can also handle webcams with much better quality)
# install webcam app
# sudo flatpak  -y install flathub org.gnome.Snapshot # may be under development and so far bad quality on my laptop


# install common tools
sudo flatpak -y install flathub org.blender.Blender
sudo flatpak -y install flathub org.gimp.GIMP
sudo dnf -y install pinta
sudo flatpak -y install flathub com.github.unrud.VideoDownloader
sudo flatpak -y install flathub org.audacityteam.Audacity
sudo dnf -y install nm-connection-editor
sudo flatpak -y install flathub com.obsproject.Studio
sudo flatpak -y install flathub org.shotcut.Shotcut

# install other important apps
sudo dnf -y install gnome-system-monitor
sudo dnf -y install gnome-characters
sudo dnf -y install gnome-calculator
sudo dnf -y install gnome-clocks
sudo dnf -y install gnome-connections
sudo dnf -y install gnome-contacts
sudo dnf -y install evince # document viewer
sudo dnf -y install simple-scan # document scanner
sudo dnf -y install gnome-font-viewer
sudo dnf -y install gnome-logs
sudo dnf -y install gnome-screenshot

sudo dnf -y install gnome-maps
sudo dnf -y install gnome-weather



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
if ! test -d "/games"; then
  sudo mkdir "/games"
fi

sudo mkdir "/games/$USER"
sudo chown "$USER:$USER" "/games/$USER"
sudo chmod -R 700 "/games/$USER"
mkdir "/games/$USER/Steam"
mv "$HOME/.local/share/Steam/steamapps" "/games/$USER/Steam/steamapps"
ln -s "/games/$USER/Steam/steamapps" "$HOME/.local/share/Steam/steamapps"
