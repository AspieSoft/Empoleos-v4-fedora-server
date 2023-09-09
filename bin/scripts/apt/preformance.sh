#!/bin/bash

dir="$1"

# install preload
sudo apt -y install preload
sudo systemctl enable preload --now

# install tlp
sudo add-apt-repository -y ppa:linrunner/tlp
sudo apt -y install tlp tlp-rdw
sudo systemctl enable tlp --now
sudo tlp start

# install thermald
sudo apt -y install thermald
sudo systemctl enable thermald --now

# disable time wasting startup programs
sudo systemctl disable postfix.service # for email server
sudo systemctl disable NetworkManager-wait-online.service # wastes time connectiong to wifi
sudo systemctl disable networkd-dispatcher.service # depends on the time waster above
sudo systemctl disable systemd-networkd.service # depends on the time waster above
sudo systemctl disable accounts-daemon.service # is a potential securite risk
sudo systemctl disable debug-shell.service # opens a giant security hole
sudo systemctl disable pppd-dns.service
sudo systemctl disable remote-fs.target

sudo apt -y remove dmraid

# change grup timeout
sudo sed -r -i 's/^GRUB_TIMEOUT=(.*)$/GRUB_TIMEOUT=0/m' /etc/default/grub
sudo update-grub
