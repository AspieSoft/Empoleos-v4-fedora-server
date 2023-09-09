#!/bin/bash

cd $(dirname "$0")
dir="$PWD"

#ServerMode=y

if [ "$(which apt)" != "" ] &>/dev/null; then
  package_manager="apt"
elif [ "$(which dnf)" != "" ] &>/dev/null; then
  package_manager="dnf"
elif [ "$(which rpm-ostree)" != "" ] &>/dev/null; then
  package_manager="rpm-ostree"
  echo "rpm-ostree is not supported yet!"
  echo "this feature may be available in the future!"
  exit
else
  echo "Error: Package Manager Unsupported"
  echo "Package Manager must be one of the following:"
  echo "apt dnf"
  exit
fi

stepCount="4"

while [ "$(ping -c1 www.google.com 2>/dev/null)" == "" ]; do
  echo "waiting for wifi..."
  sleep 10
done

sleep 1


runStep="1"
if [ -f "$dir/run/run.step" ]; then
  runStep="$(cat "$dir/run/run.step")"
fi

if [ "$ServerMode" = "y" ] && [ -f "$dir/run/run.$runStep.sh" ]; then
  while ! [ "$(sudo cat "$dir/run/run.$runStep.sh" 2>/dev/null | grep '#!NON-SERVER/DESKTOP-ONLY')" = "" ]; do
    if ! [ -f "$dir/run/run.$runStep.sh" ]; then
      break
    fi
    echo "skiping step $runStep/$stepCount (non-server / desktop only)"
    runStep="$((runStep+1))"
  done
fi


if [ -f "$dir/run/run.$runStep.sh" ]; then
  #todo: verify checksum for script before running

  echo "continuing install! $runStep/$stepCount"
  cd "$dir"
  bash "$dir/run/run.$runStep.sh" "$ServerMode" "$package_manager"
elif [ -f "$dir/run/run.$runStep.$package_manager.sh" ]; then
  #todo: verify checksum for script before running

  echo "continuing install! $runStep/$stepCount"
  cd "$dir"
  bash "$dir/run/run.$runStep.sh" "$ServerMode" "$package_manager"
else
  # disable temp auto login
  sudo rm -rf "/etc/systemd/system/getty@tty1.service.d"

  # remove install service
  sudo systemctl disable "empoleos-installer.service"
  sudo rm -f "/etc/systemd/system/empoleos-installer.service"
  sudo rm -rf "/etc/empoleos-installer"

  echo "Install Finished!"
  exit
fi

cd "$dir"

runStep="$((runStep+1))"
echo "$runStep" | sudo tee "$dir/run/run.step"


# cleanup
if [ "$package_manager" = "apt" ]; then
  sudo apt -y update
  sudo apt -y autoremove
  sudo apt -y autoclean
elif [ "$package_manager" = "dnf" ]; then
  sudo dnf clean all
  sudo dnf -y autoremove
  sudo dnf -y distro-sync
elif [ "$package_manager" = "rpm-ostree" ]; then
  #todo: figure out what rpm-ostree ceanup commands are
  echo "not yet available"
fi

# reboot system
sudo systemctl reboot
