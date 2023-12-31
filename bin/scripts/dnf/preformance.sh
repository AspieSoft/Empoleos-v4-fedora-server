#!/bin/bash

dir="$1"

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

# disable time wasting startup programs
sudo systemctl disable NetworkManager-wait-online.service
sudo systemctl disable accounts-daemon.service
sudo systemctl disable debug-shell.service
sudo systemctl disable nfs-client.target
sudo systemctl disable remote-fs.target

sudo dnf -y --noautoremove remove dmraid device-mapper-multipath

# change grub timeout
sudo sed -r -i 's/^GRUB_TIMEOUT=(.*)$/GRUB_TIMEOUT=0/m' /etc/default/grub
sudo update-grub
sudo grub2-editenv - set menu_auto_hide=1
sudo grub2-mkconfig -o /etc/grub2-efi.cfg
sudo grub2-mkconfig -o /etc/grub2.cfg
