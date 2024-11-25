#!/bin/bash

options=("logout  
lock  
reboot  
shutdown  ")

action=$(echo "$options" | wofi -c ~/config/wofi/prompt -s ~/config/wofi/style.css --dmenu)

# Check if the user selected an option
if [[ -n $action ]]; then

	case $action in
		"logout  ")
			hyprctl dispatch exit
		;;
		"lock  ")
			hyprlock
		;;
		"reboot  ")
			shutdown -r now
		;;
		"shutdown  ")
			shutdown now
		;;
	esac

fi
