# fix keyboard shortcuts
dconf reset /org/gnome/desktop/wm/keybindings/switch-to-workspace-up
dconf reset /org/gnome/desktop/wm/keybindings/switch-to-workspace-down
dconf reset /org/gnome/desktop/wm/keybindings/switch-to-workspace-left
dconf reset /org/gnome/desktop/wm/keybindings/switch-to-workspace-right

dconf reset /org/gnome/desktop/wm/keybindings/move-to-workspace-up
dconf reset /org/gnome/desktop/wm/keybindings/move-to-workspace-down
dconf reset /org/gnome/desktop/wm/keybindings/move-to-workspace-left
dconf reset /org/gnome/desktop/wm/keybindings/move-to-workspace-right

dconf reset /org/gnome/desktop/wm/keybindings/move-to-monitor-up
dconf reset /org/gnome/desktop/wm/keybindings/move-to-monitor-down
dconf reset /org/gnome/desktop/wm/keybindings/move-to-monitor-left
dconf reset /org/gnome/desktop/wm/keybindings/move-to-monitor-right

dconf reset /org/gnome/desktop/wm/keybindings/maximize
dconf reset /org/gnome/desktop/wm/keybindings/unmaximize
dconf reset /org/gnome/desktop/wm/keybindings/toggle-tiled-left
dconf reset /org/gnome/desktop/wm/keybindings/toggle-tiled-left

dconf write /org/gnome/desktop/wm/keybindings/move-to-monitor-up "['']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-monitor-down "['']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-monitor-left "['']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-monitor-right "['']"

dconf write /org/gnome/desktop/wm/keybindings/maximize "['']"
dconf write /org/gnome/desktop/wm/keybindings/unmaximize "['']"
dconf write /org/gnome/desktop/wm/keybindings/toggle-tiled-left "['']"
dconf write /org/gnome/desktop/wm/keybindings/toggle-tiled-left "['']"

dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-up "['<Super>Up']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-down "['<Super>Down']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-left "['<Super>Left']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-right "['<Super>Right']"

dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-up "['<Shift><Super>Up']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-down "['<Shift><Super>Down']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-left "['<Shift><Super>Left']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-right "['<Shift><Super>Right']"
