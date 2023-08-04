#!/bin/bash

#!NON-SERVER/DESKTOP-ONLY

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

# move gnome core extensions to root
sudo mv $HOME/.local/share/gnome-shell/extensions/* /usr/share/gnome-shell/extensions
for file in $(ls /usr/share/gnome-shell/extensions); do
  sudo -R root:root "/usr/share/gnome-shell/extensions/$file"
done

# install gnome user extension
gext -F install burn-my-windows@schneegans.github.com
gext -F install compiz-alike-magic-lamp-effect@hermes83.github.com
gext -F install clipboard-indicator@tudmotu.com

gext -F install block-caribou-36@lxylxy123456.ercli.dev
gext disable block-caribou-36@lxylxy123456.ercli.dev

gext -F install Vitals@CoreCoding.com
gext disable Vitals@CoreCoding.com

gext -F install allowlockedremotedesktop@kamens.us
gext disable allowlockedremotedesktop@kamens.us

gext -F install espresso@coadmunkee.github.com
gext disable espresso@coadmunkee.github.com
