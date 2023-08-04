#!/bin/bash

#!NON-SERVER/DESKTOP-ONLY

# install common apps
bash "./bin/scripts/apps.sh"

# install optional
#todo: make optional
bash "./bin/scripts/wine.sh"
bash "./bin/scripts/extras/developer.sh"
bash "./bin/scripts/extras/office.sh"

# install theme

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

# install gnome core extensions
sudo pip3 install --upgrade git+https://github.com/essembeh/gnome-extensions-cli

gext -F install arcmenu@arcmenu.com
gext -F install dash-to-panel@jderose9.github.com
gext -F install vertical-workspaces@G-dH.github.com
gext -F install user-theme@gnome-shell-extensions.gcampax.github.com
gext -F install gnome-ui-tune@itstime.tech

gext -F install ding@rastersoft.com
gext -F install gtk4-ding@smedius.gitlab.com

gext -F install drive-menu@gnome-shell-extensions.gcampax.github.com
gext -F install date-menu-formatter@marcinjakubowski.github.com
gext -F install batterytime@typeof.pw
gext -F install screenshot-window-sizer@gnome-shell-extensions.gcampax.github.com
gext -F install gestureimprovements@gestures
gext -F install just-perfection-desktop@just-perfection

gext -F install sane-airplane-mode@kippi
gext -F install printers@linux-man.org

gext -F install appindicatorsupport@rgcjonas.gmail.com

gext -F install window-list@gnome-shell-extensions.gcampax.github.com
gext disable window-list@gnome-shell-extensions.gcampax.github.com

gext -F install apps-menu@gnome-shell-extensions.gcampax.github.com
gext disable apps-menu@gnome-shell-extensions.gcampax.github.com

gext -F install launch-new-instance@gnome-shell-extensions.gcampax.github.com
gext disable launch-new-instance@gnome-shell-extensions.gcampax.github.com
