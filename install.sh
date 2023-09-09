#!/bin/bash

cd $(dirname "$0")
dir="$PWD"

sudo echo

#todo: verify checksums for script files based on github repo
# verify checksums
# gitSum=$(curl --silent "https://raw.githubusercontent.com/AspieSoft/Empoleos/master/install.sh" | sha256sum | sed -E 's/([a-zA-Z0-9]+).*$/\1/')
# sum=$(cat "install.sh" | sha256sum | sed -E 's/([a-zA-Z0-9]+).*$/\1/')
# if ! [ "$sum" = "$gitSum" ]; then
#   echo "error: checksum failed!"
#   exit
# fi


for arg in $@; do
  echo "$arg"
  if [ "$arg" = "--server" -o "$arg" = "-s" ]; then
    ServerMode="y"
  elif [ "$arg" = "--install" "$arg" = "--iso" -o "$arg" = "-i" ]; then
    InstallISO="y"
  fi
done

cd "/"
rootDir="/"
user="$USER"

if [ "$InstallISO" = "y" ]; then
  #todo: install iso from fedora server (remember to verify checksums before install)

  # set rootDir to use mounted directory
  cd "/mnt"
  rootDir="/mnt"
  user="ask-for-user"
  exit # temp
fi

echo "starting install..."

# install theme files
sudo tar -xzf "$dir/bin/theme/themes.tar.gz" -C "usr/share/themes"
sudo tar -xzf "$dir/bin/theme/icons.tar.gz" -C "usr/share/icons"
sudo tar -xzf "$dir/bin/theme/sounds.tar.gz" -C "usr/share/sounds"
sudo tar -xzf "$dir/bin/theme/backgrounds.tar.gz" -C "usr/share/backgrounds"

# set bash profile $PS1
if ! [ -f "etc/profile.d/bash_ps.sh" ]; then
  echo 'if [ "$PS1" ]; then' | sudo tee -a "etc/profile.d/bash_ps.sh" &>/dev/null
  echo '  PS1="\[\e[m\][\[\e[1;32m\]\u@\h\[\e[m\]:\[\e[1;34m\]\w\[\e[m\]]\[\e[0;31m\](\$?)\[\e[1;0m\]\\$ \[\e[m\]"' | sudo tee -a "etc/profile.d/bash_ps.sh" &>/dev/null
  echo 'fi' | sudo tee -a "etc/profile.d/bash_ps.sh" &>/dev/null
fi

# install installation service
sudo cp -rf "$dir/bin/empoleos-installer" "etc"
if [ "$ServerMode" = "y" ]; then
  sudo sed -r -i 's/^#ServerMode=/ServerMode=/m' "etc/empoleos-installer/run.sh"
fi
sudo rm -f "etc/empoleos-installer/empoleos-installer.service"
sudo mkdir "etc/empoleos-installer/bin"
sudo cp -rf "$dir/bin/scripts" "etc/empoleos-installer/bin"
sudo cp -rf "$dir/bin/assets" "etc/empoleos-installer/bin"
sudo cp -f "$dir/bin/empoleos-installer/empoleos-installer.service" "etc/systemd/system"


cd "$dir"
if [[ "$PWD" =~ empoleos/?$ ]]; then
  rm -rf "$PWD"
fi
cd "$rootDir"


# enable temp auto login
sudo mkdir "etc/systemd/system/getty@tty1.service.d"
echo "[Service]" | sudo tee -a "etc/systemd/system/getty@tty1.service.d/override.conf"
echo "ExecStart=" | sudo tee -a "etc/systemd/system/getty@tty1.service.d/override.conf"
echo "ExecStart=-/sbin/agetty --noissue --autologin $user %I \$TERM" | sudo tee -a "etc/systemd/system/getty@tty1.service.d/override.conf"
echo "Type=idle" | sudo tee -a "etc/systemd/system/getty@tty1.service.d/override.conf"
echo "EOT" | sudo tee -a "etc/systemd/system/getty@tty1.service.d/override.conf"


if [ "$InstallISO" = "y" ]; then
  # enable installer
  # sudo ln -s "etc/systemd/system/empoleos-installer.service" "$rootDir/etc/systemd/system/network.target.wants/empoleos-installer.service"
  # cd etc/systemd/system/network.target.wants
  # sudo ln -rs "../empoleos-installer.service" "./empoleos-installer.service"
  # cd "$rootDir"
  sudo ln -rs "/etc/systemd/system/empoleos-installer.service" "etc/systemd/system/network.target.wants/empoleos-installer.service"

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
