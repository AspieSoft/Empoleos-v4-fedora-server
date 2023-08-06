#!/bin/bash

dir="$1"

# config gnome core extensions

# - date formatter
gsettings --schemadir ~/.local/share/gnome-shell/extensions/date-menu-formatter@marcinjakubowski.github.com/schemas/ set org.gnome.shell.extensions.date-menu-formatter apply-all-panels "true"
gsettings --schemadir ~/.local/share/gnome-shell/extensions/date-menu-formatter@marcinjakubowski.github.com/schemas/ set org.gnome.shell.extensions.date-menu-formatter pattern "EEE, MMM d  h:mm aaa"

# - printers
gsettings --schemadir ~/.local/share/gnome-shell/extensions/printers@linux-man.org/schemas/ set org.gnome.shell.extensions.printers show-icon "When printing"

# - just perfection
gsettings --schemadir ~/.local/share/gnome-shell/extensions/just-perfection-desktop@just-perfection/schemas/ set org.gnome.shell.extensions.just-perfection hot-corner "false"
gsettings --schemadir ~/.local/share/gnome-shell/extensions/just-perfection-desktop@just-perfection/schemas/ set org.gnome.shell.extensions.just-perfection startup-status "0"
gsettings --schemadir ~/.local/share/gnome-shell/extensions/just-perfection-desktop@just-perfection/schemas/ set org.gnome.shell.extensions.just-perfection workspace-wrap-around "true"
gsettings --schemadir ~/.local/share/gnome-shell/extensions/just-perfection-desktop@just-perfection/schemas/ set org.gnome.shell.extensions.just-perfection window-demands-attention-focus "false"

# - disable auto airplane mode
gsettings --schemadir ~/.local/share/gnome-shell/extensions/sane-airplane-mode@kippi/schemas/ set org.gnome.shell.extensions.sane-airplane-mode enable-airplane-mode "false"
gsettings --schemadir ~/.local/share/gnome-shell/extensions/sane-airplane-mode@kippi/schemas/ set org.gnome.shell.extensions.sane-airplane-mode enable-bluetooth "false"
