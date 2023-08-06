#!/bin/bash

dir="$1"

# config gnome core extensions

# - arcmenu
gsettings --schemadir ~/.local/share/gnome-shell/extensions/arcmenu@arcmenu.com/schemas/ set org.gnome.shell.extensions.arcmenu arcmenu-extra-categories-links "[(0, false), (1, true), (2, false), (3, false), (4, true)]"
gsettings --schemadir ~/.local/share/gnome-shell/extensions/arcmenu@arcmenu.com/schemas/ set org.gnome.shell.extensions.arcmenu custom-menu-button-icon-size "24.0"
gsettings --schemadir ~/.local/share/gnome-shell/extensions/arcmenu@arcmenu.com/schemas/ set org.gnome.shell.extensions.arcmenu directory-shortcuts-list "[['Computer', 'drive-harddisk-symbolic', 'ArcMenu_Computer'], ['Home', 'user-home-symbolic', 'ArcMenu_Home'], ['Documents', '. GThemedIcon folder-documents-symbolic folder-symbolic folder-documents folder', 'ArcMenu_Documents'], ['Downloads', '. GThemedIcon folder-download-symbolic folder-symbolic folder-download folder', 'ArcMenu_Downloads'], ['Pictures', '. GThemedIcon folder-pictures-symbolic folder-symbolic folder-pictures folder', 'ArcMenu_Pictures'], ['Videos', '. GThemedIcon folder-videos-symbolic folder-symbolic folder-videos folder', 'ArcMenu_Videos'], ['Music', '. GThemedIcon folder-music-symbolic folder-symbolic folder-music folder', 'ArcMenu_Music']]"
gsettings --schemadir ~/.local/share/gnome-shell/extensions/arcmenu@arcmenu.com/schemas/ set org.gnome.shell.extensions.arcmenu extra-categories "[(0, false), (1, false), (3, true), (4, false), (2, true)]"
gsettings --schemadir ~/.local/share/gnome-shell/extensions/arcmenu@arcmenu.com/schemas/ set org.gnome.shell.extensions.arcmenu hide-overview-on-startup "true"
gsettings --schemadir ~/.local/share/gnome-shell/extensions/arcmenu@arcmenu.com/schemas/ set org.gnome.shell.extensions.arcmenu enable-menu-hotkey "false"
gsettings --schemadir ~/.local/share/gnome-shell/extensions/arcmenu@arcmenu.com/schemas/ set org.gnome.shell.extensions.arcmenu application-shortcuts-list "[['Software', 'org.gnome.Software', 'ArcMenu_Software'], ['Settings', 'org.gnome.Settings', 'org.gnome.Settings.desktop'], ['Terminal', 'org.gnome.Terminal', 'org.gnome.Terminal.desktop'], ['System Monitor', 'org.gnome.SystemMonitor', 'gnome-system-monitor.desktop']]"

# - dash to panel
gsettings --schemadir ~/.local/share/gnome-shell/extensions/dash-to-panel@jderose9.github.com/schemas/ set org.gnome.shell.extensions.dash-to-panel hide-overview-on-startup "true"
gsettings --schemadir ~/.local/share/gnome-shell/extensions/dash-to-panel@jderose9.github.com/schemas/ set org.gnome.shell.extensions.dash-to-panel intellihide "true"
gsettings --schemadir ~/.local/share/gnome-shell/extensions/dash-to-panel@jderose9.github.com/schemas/ set org.gnome.shell.extensions.dash-to-panel intellihide-behaviour "ALL_WINDOWS"
gsettings --schemadir ~/.local/share/gnome-shell/extensions/dash-to-panel@jderose9.github.com/schemas/ set org.gnome.shell.extensions.dash-to-panel intellihide-hide-from-windows "true"
gsettings --schemadir ~/.local/share/gnome-shell/extensions/dash-to-panel@jderose9.github.com/schemas/ set org.gnome.shell.extensions.dash-to-panel intellihide-only-secondary "true"
gsettings --schemadir ~/.local/share/gnome-shell/extensions/dash-to-panel@jderose9.github.com/schemas/ set org.gnome.shell.extensions.dash-to-panel isolate-monitors "true"
gsettings --schemadir ~/.local/share/gnome-shell/extensions/dash-to-panel@jderose9.github.com/schemas/ set org.gnome.shell.extensions.dash-to-panel isolate-workspaces "true"
gsettings --schemadir ~/.local/share/gnome-shell/extensions/dash-to-panel@jderose9.github.com/schemas/ set org.gnome.shell.extensions.dash-to-panel panel-element-positions '{"0":[{"element":"showAppsButton","visible":false,"position":"stackedTL"},{"element":"activitiesButton","visible":false,"position":"stackedTL"},{"element":"leftBox","visible":true,"position":"stackedTL"},{"element":"taskbar","visible":true,"position":"stackedTL"},{"element":"centerBox","visible":true,"position":"stackedBR"},{"element":"rightBox","visible":true,"position":"stackedBR"},{"element":"systemMenu","visible":true,"position":"stackedBR"},{"element":"dateMenu","visible":true,"position":"stackedBR"},{"element":"desktopButton","visible":true,"position":"stackedBR"}],"1":[{"element":"showAppsButton","visible":false,"position":"stackedTL"},{"element":"activitiesButton","visible":false,"position":"stackedTL"},{"element":"leftBox","visible":true,"position":"stackedTL"},{"element":"taskbar","visible":true,"position":"stackedTL"},{"element":"centerBox","visible":true,"position":"stackedBR"},{"element":"rightBox","visible":true,"position":"stackedBR"},{"element":"systemMenu","visible":true,"position":"stackedBR"},{"element":"dateMenu","visible":true,"position":"stackedBR"},{"element":"desktopButton","visible":true,"position":"stackedBR"}]}'
gsettings --schemadir ~/.local/share/gnome-shell/extensions/dash-to-panel@jderose9.github.com/schemas/ set org.gnome.shell.extensions.dash-to-panel dot-style-unfocused "DOTS"
gsettings --schemadir ~/.local/share/gnome-shell/extensions/dash-to-panel@jderose9.github.com/schemas/ set org.gnome.shell.extensions.dash-to-panel panel-sizes '{"0":42,"1":42}'

# - vertical workspaces
gsettings --schemadir ~/.local/share/gnome-shell/extensions/vertical-workspaces@G-dH.github.com/schemas/ set org.gnome.shell.extensions.vertical-workspaces fix-ubuntu-dock "true"
gsettings --schemadir ~/.local/share/gnome-shell/extensions/vertical-workspaces@G-dH.github.com/schemas/ set org.gnome.shell.extensions.vertical-workspaces hot-corner-action "0"
gsettings --schemadir ~/.local/share/gnome-shell/extensions/vertical-workspaces@G-dH.github.com/schemas/ set org.gnome.shell.extensions.vertical-workspaces overview-bg-blur-sigma "10"
gsettings --schemadir ~/.local/share/gnome-shell/extensions/vertical-workspaces@G-dH.github.com/schemas/ set org.gnome.shell.extensions.vertical-workspaces search-fuzzy "true"
gsettings --schemadir ~/.local/share/gnome-shell/extensions/vertical-workspaces@G-dH.github.com/schemas/ set org.gnome.shell.extensions.vertical-workspaces blur-transitions "true"

# - desktop icons
gsettings --schemadir ~/.local/share/gnome-shell/extensions/ding@rastersoft.com/schemas/ set org.gnome.shell.extensions.ding show-drop-place "false"
gsettings --schemadir ~/.local/share/gnome-shell/extensions/ding@rastersoft.com/schemas/ set org.gnome.shell.extensions.ding show-home "false"
gsettings --schemadir ~/.local/share/gnome-shell/extensions/ding@rastersoft.com/schemas/ set org.gnome.shell.extensions.ding show-volumes "false"
gsettings --schemadir ~/.local/share/gnome-shell/extensions/ding@rastersoft.com/schemas/ set org.gnome.shell.extensions.ding use-nemo "true"
# gtk4
gsettings --schemadir ~/.local/share/gnome-shell/extensions/gtk4-ding@smedius.gitlab.com/schemas/ set org.gnome.shell.extensions.gtk4-ding show-drop-place "false"
gsettings --schemadir ~/.local/share/gnome-shell/extensions/gtk4-ding@smedius.gitlab.com/schemas/ set org.gnome.shell.extensions.gtk4-ding show-home "false"
gsettings --schemadir ~/.local/share/gnome-shell/extensions/gtk4-ding@smedius.gitlab.com/schemas/ set org.gnome.shell.extensions.gtk4-ding show-second-monitor "true"
gsettings --schemadir ~/.local/share/gnome-shell/extensions/gtk4-ding@smedius.gitlab.com/schemas/ set org.gnome.shell.extensions.gtk4-ding use-nemo "true"


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
