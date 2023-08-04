#!/bin/bash

# install vscode
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
if ! test -f "/etc/yum.repos.d/vscode.repo" ; then
  echo '[code]' | sudo tee -a "/etc/yum.repos.d/vscode.repo"
  echo 'name=Visual Studio Code' | sudo tee -a "/etc/yum.repos.d/vscode.repo"
  echo 'baseurl=https://packages.microsoft.com/yumrepos/vscode' | sudo tee -a "/etc/yum.repos.d/vscode.repo"
  echo 'enabled=1' | sudo tee -a "/etc/yum.repos.d/vscode.repo"
  echo 'gpgcheck=1' | sudo tee -a "/etc/yum.repos.d/vscode.repo"
  echo 'gpgkey=https://packages.microsoft.com/keys/microsoft.asc' | sudo tee -a "/etc/yum.repos.d/vscode.repo"
fi
sudo dnf -y check-update
sudo dnf -y install code

# install other browsers
if [ "$(which "chromium" 2>/dev/null)" = "" -a "$(which "chromium-browser" 2>/dev/null)" ]; then
  sudo dnf -y install chromium
fi

if [ "$(which "firefox" 2>/dev/null)" = "" ]; then
  sudo dnf -y install firefox
fi

sudo dnf -y install epiphany
