-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
hl.on("hyprland.start", function()
    hl.exec_cmd("/home/denial/.local/scripts/launch-waybar")
    hl.exec_cmd("awww-daemon && sleep 1 && awww img ~/Downloads/greenforest.jpg")
    hl.exec_cmd("USE_LAYER_SHELL=0 vicinae server")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    -- theming with cursor
    hl.exec_cmd("dconf write /org/gnome/desktop/interface/gtk-theme \"'Capitaine Cursors'\"")
    hl.exec_cmd("hyprctl setcursor 'Capitaine Cursors' 24")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("hyprctl setcursor everforest-cursors-light 48")
    hl.exec_cmd("easyeffects --service-mode -w")
end)
