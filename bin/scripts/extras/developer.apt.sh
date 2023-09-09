#!/bin/bash

dir="$1"

# install vscode
sudo snap install --classic code

# install other browsers
if [ "$(which "chromium" 2>/dev/null)" = "" -a "$(which "chromium-browser" 2>/dev/null)" ]; then
  sudo apt -y install chromium
  sudo apt -y install chromium-browser
fi

if [ "$(which "firefox" 2>/dev/null)" = "" ]; then
  sudo apt -y install firefox
fi

sudo apt -y install epiphany
