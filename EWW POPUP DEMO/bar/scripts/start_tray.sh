#!/bin/bash

# Check if Waybar is running
if pgrep -x "waybar" > /dev/null
then
    killall waybar
fi

# Check if Waybar is installed and in the PATH
if command -v waybar > /dev/null
then
    waybar --config ./tray_config --style ./tray_style.css &
else
    echo "Waybar is not installed and/or in the path."
fi
