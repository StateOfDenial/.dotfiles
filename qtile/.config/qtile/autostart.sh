#!/usr/bin/env zsh

picom &
feh --bg-fill ~/Downloads/wallpaper-1.jpg &
xautolock -time 15 -locker "i3lock-fancy -g" -detectsleep \
    -killtime 40 -killer "systemctl suspend" \
    -notify 40 -notifier "notify-send -u critical 'Auto Lock' 'Will sleep in 30 seconds!'" &
if command vicinae; then
    vicinae server &
fi
