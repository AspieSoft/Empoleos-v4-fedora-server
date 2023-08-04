#!/bin/bash

# set theme basics
sudo gsettings set org.gnome.desktop.interface clock-format 12h
sudo gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"

# config theme settings
gsettings set org.gnome.desktop.interface gtk-theme "Fluent-round-Dark"
gsettings set org.gnome.desktop.interface icon-theme "ZorinBlue-Dark"
gsettings set org.gnome.desktop.sound theme-name "zorin"
gsettings set org.gnome.desktop.background picture-uri "file:///usr/share/backgrounds/aspiesoft/blue.webp"
gsettings set org.gnome.desktop.background picture-uri-dark "file:///usr/share/backgrounds/aspiesoft/black.webp"

gsettings set org.gnome.mutter center-new-windows "true"
gsettings set org.gnome.mutter attach-modal-dialogs "false"
gsettings set org.gnome.desktop.wm.preferences button-layout "appmenu:minimize,maximize,close"
