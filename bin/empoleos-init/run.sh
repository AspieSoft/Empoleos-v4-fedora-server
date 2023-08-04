#!/bin/bash

cd $(dirname "$0")
dir="$PWD"

#ServerMode=y

$stepCount="5"

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
  bash "$dir/run/run.$runStep.sh" "$ServerMode"
else
  sudo systemctl disable empoleos-init.service
  sudo rm -rf /etc/empoleos-init
  echo "Install Finished!"
  exit
fi

runStep="$((runStep+1))"
echo "$runStep" | sudo tee "$dir/run/run.step"


# cleanup
sudo dnf clean all
sudo dnf -y autoremove
sudo dnf -y update
sudo dnf -y distro-sync

# reboot system
sudo systemctl reboot
