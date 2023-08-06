#!/bin/bash

dir="$1"

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
