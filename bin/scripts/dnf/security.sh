#!/bin/bash

dir="$1"

sudo dnf -y install fail2ban

if ! [ -f "/etc/fail2ban/jail.local" ]; then
  sudo touch "/etc/fail2ban/jail.local"
  echo '[DEFAULT]' | sudo tee -a "/etc/fail2ban/jail.local"
  echo 'ignoreip = 127.0.0.1/8 ::1' | sudo tee -a "/etc/fail2ban/jail.local"
  echo 'bantime = 3600' | sudo tee -a "/etc/fail2ban/jail.local"
  echo 'findtime = 600' | sudo tee -a "/etc/fail2ban/jail.local"
  echo 'maxretry = 5' | sudo tee -a "/etc/fail2ban/jail.local"
  echo '' | sudo tee -a "/etc/fail2ban/jail.local"
  echo '[sshd]' | sudo tee -a "/etc/fail2ban/jail.local"
  echo 'enabled = true' | sudo tee -a "/etc/fail2ban/jail.local"
fi

sudo systemctl enable fail2ban --now

sudo dnf -y install clamav clamd clamav-update
sudo systemctl stop clamav-freshclam
sudo freshclam
sudo systemctl enable clamav-freshclam --now
sudo dnf -y install clamtk

sudo dnf -y install cronie

sudo freshclam

# add quarantine folder
if ! [ -d "/VirusScan/quarantine" ]; then
  sudo mkdir -p /VirusScan/quarantine
  sudo chmod 0664 /VirusScan
  sudo chmod 2660 /VirusScan/quarantine
  sudo chmod -R 2660 /VirusScan/quarantine
fi

# fix clamav permissions
if grep -R "^ScanOnAccess " "/etc/clamd.d/scan.conf"; then
  sudo sed -r -i 's/^ScanOnAccess (.*)$/ScanOnAccess yes/m' "/etc/clamd.d/scan.conf"
else
  echo 'ScanOnAccess yes' | sudo tee -a "/etc/clamd.d/scan.conf"
fi

if grep -R "^OnAccessMountPath " "/etc/clamd.d/scan.conf"; then
  sudo sed -r -i 's#^OnAccessMountPath (.*)$#OnAccessMountPath /#m' "/etc/clamd.d/scan.conf"
else
  echo 'OnAccessMountPath /' | sudo tee -a "/etc/clamd.d/scan.conf"
fi

if grep -R "^OnAccessPrevention " "/etc/clamd.d/scan.conf"; then
  sudo sed -r -i 's/^OnAccessPrevention (.*)$/OnAccessPrevention no/m' "/etc/clamd.d/scan.conf"
else
  echo 'OnAccessPrevention no' | sudo tee -a "/etc/clamd.d/scan.conf"
fi

if grep -R "^OnAccessExtraScanning " "/etc/clamd.d/scan.conf"; then
  sudo sed -r -i 's/^OnAccessExtraScanning (.*)$/OnAccessExtraScanning yes/m' "/etc/clamd.d/scan.conf"
else
  echo 'OnAccessExtraScanning yes' | sudo tee -a "/etc/clamd.d/scan.conf"
fi

if grep -R "^OnAccessExcludeUID " "/etc/clamd.d/scan.conf"; then
  sudo sed -r -i 's/^OnAccessExcludeUID (.*)$/OnAccessExcludeUID 0/m' "/etc/clamd.d/scan.conf"
else
  echo 'OnAccessExcludeUID 0' | sudo tee -a "/etc/clamd.d/scan.conf"
fi

if grep -R "^User " "/etc/clamd.d/scan.conf"; then
  sudo sed -r -i 's/^User (.*)$/User root/m' "/etc/clamd.d/scan.conf"
else
  echo 'User root' | sudo tee -a "/etc/clamd.d/scan.conf"
fi


# install aspiesoft clamav download scanner
if ! [ -d "/etc/aspiesoft-clamav-scanner" ]; then
  sudo mkdir -p /etc/aspiesoft-clamav-scanner
  git clone https://github.com/AspieSoft/linux-clamav-download-scanner.git
  sudo cp -rf linux-clamav-download-scanner/* /etc/aspiesoft-clamav-scanner
  rm linux-clamav-download-scanner
  sudo cp -f "$dir/bin/assets/aspiesoft-clamav-scanner/start.sh" "/etc/aspiesoft-clamav-scanner"
  sudo cp -f "$dir/bin/assets/aspiesoft-clamav-scanner/aspiesoft-clamav-download-scanner.service" "/etc/systemd/system"
  sudo systemctl daemon-reload
  sudo systemctl enable aspiesoft-clamav-download-scanner.service --now
fi


# install auto updates
sudo dnf -y install dnf-automatic
sudo sed -r -i 's/^apply_updates(\s*)=(\s*)(.*)$/apply_updates\1=\2yes/m' "/etc/dnf/automatic.conf"
sudo systemctl enable --now dnf-automatic.timer


# install pwgen
sudo dnf -y install pwgen

# install rkhunter
sudo dnf -y install rkhunter
sudo rkhunter --update -q
sudo rkhunter --propupd -q
