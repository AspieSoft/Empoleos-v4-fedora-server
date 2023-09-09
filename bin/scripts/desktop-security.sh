#!/bin/bash

dir="$1"

sudo systemctl disable sshd --now

if test -f "/etc/ssh/sshd_config"; then
  sudo sed -r -i 's/^PermitRootLogin (.*)$/PermitRootLogin no/m' "/etc/ssh/sshd_config"
  sudo sed -r -i 's/^PasswordAuthentication (.*)$/PasswordAuthentication no/m' "/etc/ssh/sshd_config"
fi

if test -f "/etc/security/pwquality.conf"; then
  sudo sed -r -i 's/^# difoc = (.*)$/  difoc = 0/m' "/etc/security/pwquality.conf"
  sudo sed -r -i 's/^# minlen = (.*)$/  minlen = 4/m' "/etc/security/pwquality.conf"
  sudo sed -r -i 's/^# dcredit = (.*)$/  dcredit = 0/m' "/etc/security/pwquality.conf"
  sudo sed -r -i 's/^# ucredit = (.*)$/  ucredit = 0/m' "/etc/security/pwquality.conf"
  sudo sed -r -i 's/^# lcredit = (.*)$/  lcredit = 0/m' "/etc/security/pwquality.conf"
  sudo sed -r -i 's/^# ocredit = (.*)$/  ocredit = 0/m' "/etc/security/pwquality.conf"
  sudo sed -r -i 's/^# minclass = (.*)$/  minclass = 0/m' "/etc/security/pwquality.conf"
  sudo sed -r -i 's/^# maxrepeat = (.*)$/  maxrepeat = 0/m' "/etc/security/pwquality.conf"
  sudo sed -r -i 's/^# gecoscheck = (.*)$/  gecoscheck = 0/m' "/etc/security/pwquality.conf"
  sudo sed -r -i 's/^# dictcheck = (.*)$/  dictcheck = 0/m' "/etc/security/pwquality.conf"
  sudo sed -r -i 's/^# usercheck = (.*)$/  usercheck = 1/m' "/etc/security/pwquality.conf"
  sudo sed -r -i 's/^# usersubstr = (.*)$/  usersubstr = 0/m' "/etc/security/pwquality.conf"
  sudo sed -r -i 's/^# enforcing = (.*)$/  enforcing = 1/m' "/etc/security/pwquality.conf"
  sudo sed -r -i 's/^# retry = (.*)$/  retry = 3/m' "/etc/security/pwquality.conf"
  sudo sed -r -i 's/^# local_users_only$/  local_users_only/m' "/etc/security/pwquality.conf"
fi
