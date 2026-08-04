#!/bin/bash

# Find the active user and DBUS session to display notifications in the X/Wayland server
USER_NAME=$(who | awk 'NR==1{print $1}')
USER_ID=$(id -u "$USER_NAME")
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$USER_ID/bus"

# Check system state
STATUS=$(cat /sys/class/power_supply/AC/online)

if [ "$STATUS" = "1" ]; then
    sudo -u "$USER_NAME" DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION_BUS_ADDRESS dunstify "Power Manager" "🔌 Charger Plugged In" -i battery-charging
else
    sudo -u "$USER_NAME" DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION_BUS_ADDRESS dunstify "Power Manager" "🔋 Charger Unplugged" -i battery-empty
fi
