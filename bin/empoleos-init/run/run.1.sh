#!/bin/bash

ServerMode="$1"

# run install scripts
bash "./bin/scripts/langs.sh"
bash "./bin/scripts/preformance.sh"
bash "./bin/scripts/security.sh"
bash "./bin/scripts/fix.sh"
bash "./bin/scripts/shortcuts.sh"

# run non-server desktop install scripts
if ! [ "$ServerMode" = "y" ]; then
  bash "./bin/scripts/desktop.sh"
  bash "./bin/scripts/desktop-security.sh"
fi
