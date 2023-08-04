#!/bin/bash

# install theme files
sudo tar -xvzf ./bin/assets/theme/themes.tar.gz -C /usr/share/themes
sudo tar -xvzf ./bin/assets/theme/icons.tar.gz -C /usr/share/icons
sudo tar -xvzf ./bin/assets/theme/sounds.tar.gz -C /usr/share/sounds
sudo tar -xvzf ./bin/assets/theme/backgrounds.tar.gz -C /usr/share/backgrounds

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

# config gnome user extension

# - burn my windows
mkdir -p "~/.config/burn-my-windows/profiles"
cp ./bin/assets/extensions/burn-my-windows.conf "~/.config/burn-my-windows/profiles"
gsettings --schemadir ~/.local/share/gnome-shell/extensions/burn-my-windows@schneegans.github.com/schemas/ set org.gnome.shell.extensions.burn-my-windows active-profile "~/.config/burn-my-windows/profiles/burn-my-windows.conf"


# other config options
gsettings set org.gnome.TextEditor restore-session "false"


bash "./bin/scripts/fix-keyboard-shortcuts.sh"


# copy extension settings for new users
sudo mkdir -p "/etc/skel/.local/share/gnome-shell/extensions"
sudo mkdir -p "/etc/skel/.config"
sudo cp -rf "$HOME/.local/share/gnome-shell/extensions" "/etc/skel/.local/share/gnome-shell/extensions"
sudo cp -rf "$HOME/.config/burn-my-windows" "/etc/skel/.config"
