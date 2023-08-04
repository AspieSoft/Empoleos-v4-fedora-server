#!/bin/bash

cd $(dirname "$0")
dir="$PWD"

#todo: verify checksums for script files based on github repo

if [ "$1" = "--server" -o "$1" = "-s" ]; then
  ServerMode="y"
fi

sudo echo


function cleanup {
  if ! [ "$serverMode" = "y" ]; then
    # reset login timeout
    sudo sed -r -i 's/^Defaults([\t ]+)(.*)env_reset(.*), (timestamp_timeout=1801,?\s*)+$/Defaults\1\2env_reset\3/m' /etc/sudoers &>/dev/null
  fi

  cd "$dir"
}
trap cleanup EXIT

function cleanupexit {
  cleanup
  exit
}
trap cleanupexit SIGINT

# extend login timeout
sudo sed -r -i 's/^Defaults([\t ]+)(.*)env_reset(.*)$/Defaults\1\2env_reset\3, timestamp_timeout=1801/m' /etc/sudoers &>/dev/null


sudo dnf -y update

if ! grep -R "^# Added for Speed" "/etc/dnf/dnf.conf"; then
  sudo sed -r -i 's/^best=(.*)$/best=True/m' "/etc/dnf/dnf.conf"
  #echo "fastestmirror=True" | sudo tee -a "/etc/dnf/dnf.conf"
  echo "max_parallel_downloads=10" | sudo tee -a "/etc/dnf/dnf.conf"
  echo "defaultyes=True" | sudo tee -a "/etc/dnf/dnf.conf"
  echo "keepcache=True" | sudo tee -a "/etc/dnf/dnf.conf"
  echo "install_weak_deps=False" | sudo tee -a "/etc/dnf/dnf.conf"
fi

sudo dnf -y install nano
sudo dnf -y install neofetch

# set bash profile $PS1
if ! [ -f "/etc/profile.d/bash_ps.sh" ]; then
  echo 'if [ "$PS1" ]; then' | sudo tee -a /etc/profile.d/bash_ps.sh &>/dev/null
  echo '  PS1="\[\e[m\][\[\e[1;32m\]\u@\h\[\e[m\]:\[\e[1;34m\]\w\[\e[m\]]\[\e[0;31m\](\$?)\[\e[1;0m\]\\$ \[\e[m\]"' | sudo tee -a /etc/profile.d/bash_ps.sh &>/dev/null
  echo 'fi' | sudo tee -a /etc/profile.d/bash_ps.sh &>/dev/null
fi


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

# install media codecs
sudo dnf install -y --skip-broken @multimedia
sudo dnf -y groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin --skip-broken
sudo dnf -y groupupdate sound-and-video
sudo dnf -y install ffmpeg
sudo dnf -y install libwebp libwebp-devel

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
# sudo snap install snap-store
sudo snap refresh

sudo dnf clean all
sudo dnf -y autoremove
sudo dnf -y update
sudo dnf -y distro-sync


# run install scripts
bash "./bin/scripts/langs.sh"
bash "./bin/scripts/preformance.sh"
bash "./bin/scripts/security.sh"
bash "./bin/scripts/fix.sh"
bash "./bin/scripts/shortcuts.sh"

# run non server install scripts
if ! [ "$ServerMode" = "y" ]; then
  bash "./bin/scripts/desktop.sh"
  bash "./bin/scripts/desktop-security.sh"
  bash "./bin/scripts/apps.sh"

  # install optional
  #todo: make optional
  bash "./bin/scripts/wine.sh"
  bash "./bin/scripts/extras/developer.sh"
  bash "./bin/scripts/extras/office.sh"

  # install theme
  #todo: may need to run theme config scripts after a reboot
  bash "./bin/scripts/theme.sh"
fi


# install auto updates
if [ "$ServerMode" = "y" ]; then
  sudo sed -r -i 's/^#ServerMode=$/ServerMode=/m' "$dir/bin/apps/empoleos/update.sh"
fi
sudo cp -rf "./bin/apps/empoleos" "/etc"
sudo rm -f "/etc/empoleos/empoleos.service"
sudo cp -f "./bin/apps/empoleos/empoleos.service" "/etc/systemd/system"
gitVer="$(curl --silent 'https://api.github.com/repos/AspieSoft/Empoleos/releases/latest' | grep '\"tag_name\":' | sed -E 's/.*\"([^\"]+)\".*/\1/')"
echo "$gitVer" | sudo tee "/etc/empoleos/version.txt"

sudo systemctl daemon-reload
sudo systemctl enable empoleos.service --now


# cleanup
cleanup

cd "$dir"
if [[ "$PWD" =~ empoleos/?$ ]]; then
  rm -rf "$PWD"
fi

sudo dnf clean all
sudo dnf -y autoremove
sudo dnf -y update
sudo dnf -y distro-sync

echo "Install Finished!"

# restart gnome
if ! [ "$ServerMode" = "y" ]; then
  echo
  echo "Ready To Restart!"
  echo
  read -n1 -p "Press any key to continue..." input ; echo >&2

  sudo systemctl reboot
fi
