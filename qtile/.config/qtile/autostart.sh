#!/usr/bin/env zsh

#wlr-randr --output DP-2 --preferred --mode 3440x1440@144 --pos 0,0 --output DP-3 --mode 1920x1080@144.001007 --pos -1920,0 
#swaybg -i ~/Downloads/wall3.jpg -m fill &
xrandr --output DP-2 --primary --mode 3440x1440 --rate 144 --pos 1920x0 --output DP-3 --mode 1920x1080 --rate 144 --pos 0x0
feh --bg-fill ~/Downloads/wall4.jpg &
#picom &
