#!/bin/bash

# install preload
sudo dnf -y copr enable elxreno/preload
sudo dnf -y install preload
sudo systemctl enable preload --now

# install tlp
sudo dnf -y install tlp tlp-rdw
sudo systemctl enable tlp --now
sudo tlp start

# install thermald
sudo dnf -y install thermald
sudo systemctl enable thermald --now

# sudo dnf -y install gnome-power-manager power-profiles-daemon
sudo dnf -y install power-profiles-daemon
sudo systemctl enable power-profiles-daemon --now

# disable time wasting startup programs
sudo systemctl disable NetworkManager-wait-online.service
sudo systemctl disable accounts-daemon.service
sudo systemctl disable debug-shell.service
sudo systemctl disable nfs-client.target
sudo systemctl disable remote-fs.target

sudo dnf -y --noautoremove remove dmraid device-mapper-multipath

# change grup timeout
sudo sed -r -i 's/^GRUB_TIMEOUT=(.*)$/GRUB_TIMEOUT=0/m' /etc/default/grub
sudo update-grub


# temp increace preformance if charging
PowerThreshhold=90
LowPowerThreshhold=20
powerFile=$(upower -e | grep battery_)
if [ "$powerFile" = "" -o "$(upower -i "$file" | grep 'time to empty')" = "" ]; then
  sudo powerprofilesctl set balanced # fallback incase preformance mode does not exist
  sudo powerprofilesctl set preformance
else
  setBalanced="0"
  for file in $powerFile; do
    power=$(upower -i "$file" | grep percentage)
    if [ "${power//[^0-9]/}" -lt "$PowerThreshhold" ]; then
      setBalanced="1"
      if [ "${power//[^0-9]/}" -lt "$LowPowerThreshhold" ]; then
        setBalanced="2"
      fi
      break
    fi
  done

  if [ "$setBalanced" = "2" ]; then
    sudo powerprofilesctl set power-saver
  elif [ "$setBalanced" = "1" ]; then
    sudo powerprofilesctl set balanced
  else
    sudo powerprofilesctl set balanced # fallback incase preformance mode does not exist
    sudo powerprofilesctl set preformance
  fi
fi
