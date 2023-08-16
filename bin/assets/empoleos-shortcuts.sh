#!/bin/bash

#todo: add functions to detect dnf, flatpak, and snap install and remove commands for backups

# optional useful functions
function update {
  sudo dnf -y update
  sudo bash /etc/empoleos/update.sh
  sudo dnf clean all
}

function backup {
  update
  sudo bash /etc/empoleos/backup.sh
}

function avscan {
  local scanDir="$1"
  if [ "$scanDir" = "" ]; then
    scanDir="$HOME"
  fi
  sudo nice -n 15 clamscan -r --bell --move="/VirusScan/quarantine" --exclude-dir="/VirusScan/quarantine" --exclude-dir="/home/$USER/.clamtk/viruses" --exclude-dir="smb4k" --exclude-dir="/run/user/$USER/gvfs" --exclude-dir="/home/$USER/.gvfs" --exclude-dir=".thunderbird" --exclude-dir=".mozilla-thunderbird" --exclude-dir=".evolution" --exclude-dir="Mail" --exclude-dir="kmail" --exclude-dir="^/sys" "$scanDir"
}

function mvlink {
  mv "$1" "$2"
  ln -s "$2" "$1"
}
