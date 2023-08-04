#!/bin/bash

cd $(dirname "$0")
dir="$PWD"

sudo echo

#todo: verify checksums for script files based on github repo

for arg in $@; do
  echo "$arg"
  if [ "$arg" = "--server" -o "$arg" = "-s" ]; then
    ServerMode="y"
  elif [ "$arg" = "--install" "$arg" = "--iso" -o "$arg" = "-i" ]; then
    InstallISO="y"
  fi
done

rootDir=""
user="$USER"

if [ "$InstallISO" = "y" ]; then
  #todo: install iso from fedora server (remember to verify checksums before install)

  # set rootDir to use mounted directory
  rootDir="/mnt"
  user="ask-for-user"
  exit # temp
fi

echo "starting install..."

# install theme files
sudo tar -xvzf "./bin/assets/theme/themes.tar.gz" -C "$rootDir/usr/share/themes"
sudo tar -xvzf "./bin/assets/theme/icons.tar.gz" -C "$rootDir/usr/share/icons"
sudo tar -xvzf "./bin/assets/theme/sounds.tar.gz" -C "$rootDir/usr/share/sounds"
sudo tar -xvzf "./bin/assets/theme/backgrounds.tar.gz" -C "$rootDir/usr/share/backgrounds"

# set bash profile $PS1
if ! [ -f "$rootDir/etc/profile.d/bash_ps.sh" ]; then
  echo 'if [ "$PS1" ]; then' | sudo tee -a "$rootDir/etc/profile.d/bash_ps.sh" &>/dev/null
  echo '  PS1="\[\e[m\][\[\e[1;32m\]\u@\h\[\e[m\]:\[\e[1;34m\]\w\[\e[m\]]\[\e[0;31m\](\$?)\[\e[1;0m\]\\$ \[\e[m\]"' | sudo tee -a "$rootDir/etc/profile.d/bash_ps.sh" &>/dev/null
  echo 'fi' | sudo tee -a "$rootDir/etc/profile.d/bash_ps.sh" &>/dev/null
fi

# install installation service
sudo cp -rf "./bin/empoleos-installer" "$rootDir/etc"
if [ "$ServerMode" = "y" ]; then
  sudo sed -r -i 's/^#ServerMode=/ServerMode=/m' "$rootDir/etc/empoleos-installer/run.sh"
fi
sudo rm -f "$rootDir/etc/empoleos-installer/empoleos-installer.service"
sudo mkdir "$rootDir/etc/empoleos-installer/bin"
sudo cp -rf "./bin/scripts" "$rootDir/etc/empoleos-installer/bin"
sudo cp -rf "./bin/assets" "$rootDir/etc/empoleos-installer/bin"
sudo cp -f "./bin/empoleos-installer/empoleos-installer.service" "$rootDir/etc/systemd/system"

# sudo systemctl daemon-reload
# sudo systemctl enable empoleos-installer.service
# sudo ln -s "/$rootDir/etc/systemd/system/empoleos-installer.service" "/etc/systemd/system/network.target.wants/empoleos-installer.service"

cd "$dir"
if [[ "$PWD" =~ empoleos/?$ ]]; then
  rm -rf "$PWD"
fi


# enable temp auto login
sudo mkdir "$rootDir/etc/systemd/system/getty@tty1.service.d"
echo "[Service]" | sudo tee -a "$rootDir/etc/systemd/system/getty@tty1.service.d/override.conf"
echo "ExecStart=" | sudo tee -a "$rootDir/etc/systemd/system/getty@tty1.service.d/override.conf"
echo "ExecStart=-/sbin/agetty --noissue --autologin $user %I \$TERM" | sudo tee -a "$rootDir/etc/systemd/system/getty@tty1.service.d/override.conf"
echo "Type=idle" | sudo tee -a "$rootDir/etc/systemd/system/getty@tty1.service.d/override.conf"
echo "EOT" | sudo tee -a "$rootDir/etc/systemd/system/getty@tty1.service.d/override.conf"


if [ "$InstallISO" = "y" ]; then
  # enable installer
  # sudo ln -s "$rootDir/etc/systemd/system/empoleos-installer.service" "$rootDir/etc/systemd/system/network.target.wants/empoleos-installer.service"
  # cd $rootDir/etc/systemd/system/network.target.wants
  # sudo ln -rs "../empoleos-installer.service" "./empoleos-installer.service"
  # cd "$dir"
  sudo ln -rs "/etc/systemd/system/empoleos-installer.service" "$rootDir/etc/systemd/system/network.target.wants/empoleos-installer.service"

  #todo: unmount directory

  # reboot
  sudo systemctl reboot
else
  # enable installer
  sudo systemctl daemon-reload
  sudo systemctl enable empoleos-installer.service

  # start installer
  sudo systemctl start empoleos-installer.service
fi
