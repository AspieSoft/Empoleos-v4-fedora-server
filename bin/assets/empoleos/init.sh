#!/bin/bash

# schedule auto updates
if ! [[ $(crontab -l) == *"#empoleos-updates"* ]] ; then
  crontab -l | { cat; echo '0 2 * * * sudo bash /etc/empoleos/update.sh #empoleos-updates'; } | crontab -
fi

# schedule auto backups
#* Notice: Auto Backups Are Not Yet Available
#* Enabling the below code will run a script that currently does nothing but exit with an error code of 1
# if ! [[ $(crontab -l) == *"#empoleos-backups"* ]] ; then
#   crontab -l | { cat; echo '0 2 * * * sudo bash /etc/empoleos/backup.sh #empoleos-backups'; } | crontab -
# fi

# run update
sudo bash /etc/empoleos/update.sh

# run backup
#* Notice: Auto Backups Are Not Yet Available
#* Enabling the below code will run a script that currently does nothing but exit with an error code of 1
# sudo bash /etc/empoleos/backup.sh
