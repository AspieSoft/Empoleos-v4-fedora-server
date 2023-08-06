#!/bin/bash

ServerMode="$1"
dir="$PWD"

if ! grep -R "^# Added for Speed" "/etc/dnf/dnf.conf"; then
  sudo sed -r -i 's/^best=(.*)$/best=True/m' "/etc/dnf/dnf.conf"
  #echo "fastestmirror=True" | sudo tee -a "/etc/dnf/dnf.conf"
  echo "max_parallel_downloads=10" | sudo tee -a "/etc/dnf/dnf.conf"
  echo "defaultyes=True" | sudo tee -a "/etc/dnf/dnf.conf"
  echo "keepcache=True" | sudo tee -a "/etc/dnf/dnf.conf"
  echo "install_weak_deps=False" | sudo tee -a "/etc/dnf/dnf.conf"
fi

sudo dnf -y update

# install ufw (firewall)
sudo dnf -y install ufw
sudo systemctl disable firewalld
sudo systemctl enable ufw --now
sudo ufw delete allow SSH
sudo ufw delete allow to 244.0.0.251 app mDNS
sudo ufw delete allow to ff02::fb app mDNS
echo -e "y\n" | sudo ufw delete 1

if [ "$ServerMode" = "y" ]; then
  sudo ufw limit 22/tcp
  sudo ufw allow 80/tcp
  sudo ufw allow 443/tcp
fi

sudo ufw default deny incoming
sudo ufw default allow outgoing

sudo ufw enable

# add rpmfusion repos
sudo dnf -y install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf -y install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf -y install fedora-workstation-repositories
sudo fedora-third-party enable
sudo fedora-third-party refresh
sudo dnf -y groupupdate core
sudo dnf -y config-manager --set-enabled google-chrome

# cleanup
sudo dnf clean all
sudo dnf -y autoremove
sudo dnf -y distro-sync

# install media codecs
sudo dnf install -y --skip-broken @multimedia
sudo dnf -y groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin --skip-broken
sudo dnf -y groupupdate sound-and-video
sudo dnf -y install ffmpeg
sudo dnf -y install libwebp libwebp-devel
sudo dnf -y install webp-pixbuf-loader

# add flatpak
sudo dnf -y install flatpak
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak update -y --noninteractive

# install snap
sudo dnf -y install snapd
sudo ln -s /var/lib/snapd/snap /snap
sudo systemctl enable snapd --now
sudo snap refresh #fix: not seeded yet will trigger and fix itself for the next command
sudo snap install core
sudo snap refresh core
sudo snap refresh

# cleanup
sudo dnf clean all
sudo dnf -y autoremove
sudo dnf -y distro-sync

# run install scripts
bash "$dir/bin/scripts/preformance.sh" "$dir"
bash "$dir/bin/scripts/fix.sh" "$dir"
bash "$dir/bin/scripts/langs.sh" "$dir"
bash "$dir/bin/scripts/security.sh" "$dir"
bash "$dir/bin/scripts/shortcuts.sh" "$dir"

# run non-server desktop install scripts
if ! [ "$ServerMode" = "y" ]; then
  bash "$dir/bin/scripts/desktop.sh" "$dir"
  bash "$dir/bin/scripts/desktop-security.sh" "$dir"

  # install common apps
  bash "$dir/bin/scripts/apps.sh" "$dir"

  # install optional
  #todo: make optional
  bash "$dir/bin/scripts/extras/wine.sh" "$dir"
  bash "$dir/bin/scripts/extras/developer.sh" "$dir"
  bash "$dir/bin/scripts/extras/office.sh" "$dir"

  # install theme
  bash "$dir/bin/scripts/theme/config.sh" "$dir"
  bash "$dir/bin/scripts/theme/core-extensions.sh" "$dir"
fi
