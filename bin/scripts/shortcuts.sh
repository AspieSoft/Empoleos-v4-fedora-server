#!/bin/bash

dir="$1"

# install shortcuts
if ! [ -f "/etc/profile.d/empoleos.sh" ]; then
  sudo cp "$dir/bin/assets/empoleos-shortcuts.sh" "/etc/profile.d/empoleos.sh"
fi
